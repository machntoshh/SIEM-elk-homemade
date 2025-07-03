# SIEM homemade feito com ELK Stack
### Feito em uma VM Ubuntu

Projeto de lab de cibersegurança no qual instalei e configurei um SIEM (Security Information and Event Management) em uma máquina virtual Ubuntu, utilizando ferramentas como Elasticsearch, Logstash, Kibana e Filebeat.

Objetivo: Mostrar habilidades práticas de coleta, armazenamento, análise e visualização de logs de segurança.

## Tecnologias

| Ferramenta      | Função                                  |
|-----------------|------------------------------------------|
| Ubuntu 20.04/22.04 | Sistema operacional base               |
| Elasticsearch   | Armazenamento e indexação de logs        |
| Logstash        | Processamento e transformação dos dados  |
| Kibana          | Visualização dos logs                    |
| Filebeat        | Coletor de logs de sistema               |


## Instalação do SIEM (comandos principais)
### Feitas com pesquisas na net já que não possuia o conhecimento, comandos em ordem de stack

```bash
sudo apt update && sudo apt upgrade -y

sudo apt install openjdk-11-jdk -y

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt install apt-transport-https -y
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update

sudo apt install elasticsearch -y
sudo systemctl enable --now elasticsearch

sudo apt install logstash -y
sudo systemctl enable --now logstash

sudo apt install kibana -y
sudo systemctl enable --now kibana

sudo apt install filebeat -y
sudo filebeat modules enable system
sudo filebeat setup
sudo systemctl enable --now filebeat
```

## Kibana na web

```
http://localhost:5601
```

## Realizando a simulação de Eventos de Segurança

Um script Bash foi criado com pesquisas para simular atividades suspeitas e administrativas que geram logs, como:

- Tentativas de login inválidas via SSH
- Uso de `sudo`
- Criação de usuário

### `testes/siem_teste_eventos.sh`

```bash
sudo ./siem_teste_eventos.sh
```

> Após executar o script, os eventos serão enviados ao Filebeat serão visualizados no Kibana web na aba "Discover".

## Consultas feitas no Kibana web

**Login inválido:**
```kibana
event.dataset : "system.auth" AND message : "Failed password"
```

**Comando sudo:**
```kibana
event.dataset : "system.auth" AND message : "sudo"
```

**Criação de usuário:**
```kibana
message : "useradd"
```

![Captura do projeto](https://github.com/user-attachments/assets/e4e2d694-16c4-4ad8-b190-695cc8ec30e4)


---

**Eric Marques Gomes | Análista de cibersegurança**  
