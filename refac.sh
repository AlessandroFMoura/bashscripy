#!/usr/bin/env bash

remetente="alessandrof@id.uff.br"
destinatario="alessandronahal@gmail.com"
assundo="Fita presa"
corpo="Segue em anexo o relatório do problema!"

pass=$(cat .secret_vault.txt | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -salt -pass pass:'secret#vault!password')

# element=$(mtx status | grep -i data) 

cat novo.txt > texto.txt  # No lugar do cat use o comando mtx status | grep -i data para salvar a saída dentro de um arquivo de texto
# comando=$(mtx status | grep -i data)

linha=$(grep -cve '^$' texto.txt) # o awk '{print $1+1}' faz a leitura das linhas incrementando mais 1

touch marcador.txt
echo "linha 1" > marcador.txt
echo "linha 2" >> marcador.txt
echo "linha 3" >> marcador.txt

macador=$(grep -cve '^$' marcador.txt)

count=1

touch contador.txt
saida=$(grep -cve '^$' contador.txt)

while [ $count -le $linha ]; do
    
    gaveta=$(head -n "${count}" texto.txt | cut -d ' ' -f 4 | sed -n "${count}p" | sed 's/:.*//' )
    condicao=$(head -n "${count}" texto.txt | cut -d ' ' -f 4 | sed -n "${count}p"  | sed 's/.://')

    if [[ $condicao = "Full" ]]; then
        numero=$(head texto.txt | sed -n "${count}p" | cut -d ' ' -f 7) # pega a numeração do Storage Element
        
        echo "mtx unload $numero $gaveta"
        
        if [ $saida -eq 3 ]; then
   
            if [[ $condicao = "Full" ]]; then
                echo "mtx unload $numero $gaveta" >> log.log
                ultimo_unload=true
         
            fi
        fi
    fi
    
    sleep 0.5 # Ajustar o tempo de retirada da fita
    count=$((count+1))
done

echo "$saida saida"

while [ $saida -le $macador ]; do
    sleep 3 # Ajustar o tempo
    
    echo "Populando" >> contador.txt
    ./refac.sh
    
    if [ -f log.log ]; then   
        sendemail -f $remetente -t $destinatario -u $assundo -m $corpo -a log.log -s smtp.gmail.com:587 -o tls=yes -xu $remetente -xp $pass > /dev/null 2>&1
        echo "E-mail enviado com sucesso!"
    fi

    rm -f texto.txt contador.txt
    rm -f log.log > /dev/null 2>&1 
    rm -f marcador.txt > /dev/null 2>&1 
    
    break;
done