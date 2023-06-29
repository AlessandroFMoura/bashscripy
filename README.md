# bashscripy

Esse script está em contrução, tem o objetivo de retirar as fitas das gavetas do robô gerenciado pelo bacula.

No lugar do remetente coloque o e-mail que ficará responsável por fazer o envio:
No lugar do destinatario coloque o e-mail que ficará responsável pelo recebimento:

remetente="emailremetente@mail.com"
destinatario="emaildestinatario@mail.com"

Na variável pass foi necessário criptografar a senha para isso, use o seguinte comando no terminal:

echo 'senha_para_criptografar' | openssl enc -aes-256-cbc -md sha512 -a -pbkdf2 -iter 100000 -salt -pass pass:'secret#vault!password' > .secret_vault.txt

Ela pode ser descriptografada dento da variável pass:

pass=$(cat ~/.secret_vault.txt | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -salt -pass pass:'secret#vault!password')

