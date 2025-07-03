#!/bin/bash

# Requer sudo
if [[ $EUID -ne 0 ]]; then
  echo "Por favor, execute como root: sudo ./siem_teste_eventos.sh"
  exit 1
fi

echo "🛡️  Iniciando simulação de eventos para SIEM..."

# 1. Tentativa de login inválido via SSH
echo "➡️  Simulando login SSH inválido..."
ssh fakeuser@localhost -o StrictHostKeyChecking=no -o ConnectTimeout=2

# 2. Criação de novo usuário
echo "➡️  Criando usuário 'testuser'..."
useradd -m testuser

# 3. Ação com sudo
echo "➡️  Executando comando com sudo..."
sudo ls /root > /dev/null

# 4. Mudança de permissão em arquivo sensível
echo "➡️  Alterando permissões de /etc/passwd (simulado)..."
chmod 777 /etc/passwd
chmod 644 /etc/passwd

# 5. Reinício de serviço
echo "➡️  Reiniciando o serviço SSH..."
systemctl restart ssh

# 6. Falha de sudo (executado por testuser)
echo "➡️  Simulando falha de sudo com usuário sem privilégio..."
runuser -l testuser -c 'sudo ls /root'

# 7. Encerramento de sessão (logoff)
echo "➡️  Simulando logout..."
pkill -KILL -u testuser

echo "✅  Simulação concluída. Verifique os logs no Kibana (Discover > filebeat-*)"
