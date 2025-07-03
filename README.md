# 🛡️ Projeto: SIEM Caseiro com ELK Stack (Ubuntu VM)

Este é um projeto de laboratório de cibersegurança no qual instalei e configurei um SIEM (Security Information and Event Management) em uma máquina virtual Ubuntu, utilizando ferramentas open-source como Elasticsearch, Logstash, Kibana e Filebeat.

O objetivo é demonstrar habilidades práticas em coleta, armazenamento, análise e visualização de logs de segurança.

## 🚀 Tecnologias Utilizadas

| Ferramenta      | Função                                  |
|-----------------|------------------------------------------|
| Ubuntu 20.04/22.04 | Sistema operacional base               |
| Elasticsearch   | Armazenamento e indexação de logs        |
| Logstash        | Processamento e transformação dos dados  |
| Kibana          | Visualização dos logs                    |
| Filebeat        | Coletor de logs de sistema               |
| (Opcional) Auditbeat | Monitoramento de atividades e arquivos |

## 🖥️ Estrutura do Projeto

```
VM Ubuntu (VMware)
├── Elasticsearch
├── Logstash
├── Kibana
└── Filebeat
    └── Módulo "system" habilitado
```

## ⚙️ Instalação do SIEM (comandos principais)

```bash
# Atualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar Java (pré-requisito)
sudo apt install openjdk-11-jdk -y

# Adicionar repositório ELK
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt install apt-transport-https -y
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update

# Instalar e ativar Elasticsearch
sudo apt install elasticsearch -y
sudo systemctl enable --now elasticsearch

# Instalar e ativar Logstash
sudo apt install logstash -y
sudo systemctl enable --now logstash

# Instalar e ativar Kibana
sudo apt install kibana -y
sudo systemctl enable --now kibana

# Instalar e configurar Filebeat
sudo apt install filebeat -y
sudo filebeat modules enable system
sudo filebeat setup
sudo systemctl enable --now filebeat
```

## 🔎 Acessando o Kibana

Abra no navegador:

```
http://localhost:5601
```

Ou, se estiver usando a VM em rede:

```
http://<IP-da-VM>:5601
```

## 🧪 Simulação de Eventos de Segurança

Um script Bash foi criado para simular atividades suspeitas e administrativas que geram logs, como:

- Tentativas de login inválidas via SSH
- Uso de `sudo`
- Criação de usuário
- Modificação de permissões em arquivos críticos
- Reinício de serviços

### 📂 `testes/siem_teste_eventos.sh`

```bash
sudo ./siem_teste_eventos.sh
```

> Após executar o script, os eventos serão enviados ao Filebeat e visualizáveis no Kibana em "Discover".

## 🔍 Consultas no Kibana (exemplos)

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

## 📌 Possibilidades de Expansão

- Integração com Auditbeat para detectar alterações em arquivos críticos
- Regras de alerta com Elastalert ou Wazuh
- Detecção de brute force, escalonamento de privilégios e movimentos laterais
- Envio de alertas por e-mail ou Telegram
- Implantação em múltiplas máquinas com Logstash centralizador

## 🧾 Como este projeto aparece no meu currículo

> 🔒 **SIEM Caseiro com ELK Stack**  
> Projeto pessoal de cibersegurança com instalação e configuração de um sistema SIEM completo usando Elasticsearch, Logstash, Kibana e Filebeat. Capaz de capturar, armazenar e visualizar eventos de segurança do sistema em tempo real. Inclui simulação de eventos como login inválido, uso de sudo e alterações em arquivos sensíveis.

## 👤 Autor

**Eric Marques Gomes**  
[Seu LinkedIn ou GitHub aqui]
