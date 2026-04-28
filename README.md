# Sprint 2
## TIL-ICE: Sistema de Monitoramento Térmico e de Umidade da Tilápia

O **TIL-ICE** é uma solução de IoT (Internet das Coisas) focada na preservação da cadeia de frio para o transporte marítimo de tilápia. O projeto visa reduzir perdas financeiras e desperdícios de carga através do monitoramento contínuo de temperatura e umidade dentro de containers reefer.

## 📋 Contextualização e Justificativa
O mercado global de tilápia movimenta bilhões de dólares anualmente, mas enfrenta desafios logísticos críticos. Estima-se que:
* **35%** dos alimentos aquáticos são perdidos ou desperdiçados globalmente
* **15%** desse desperdício ocorre por má administração térmica em containers.
* Falhas no degelo podem causar perda de peso por gotejamento entre **9% e 25%**.

A deterioração da tilápia acelera drasticamente conforme a temperatura sobe: enquanto a $0^{\circ}C$ a conservação dura ~15 dias, a $15^{\circ}C$ esse tempo cai para apenas ~2 dias

## 🚀 Objetivos
* Implementar sensores estratégicos para garantir a uniformidade da conservação.
* Reduzir perdas por falhas na cadeia fria e desidratação (gotejamento)
* Estruturar um dashboard em tempo real para identificação rápida de desvios e suporte à tomada de decisão

## 🛠️ Requisitos do Sistema

### Funcionais
1. **Coleta de Dados:** Monitoramento de temperatura (Celsius) e umidade relativa (%)
2. **Alertas:** Geração de notificações caso os valores saiam da faixa definida
3. **Persistência:** Armazenamento automático em banco de dados e envio para servidor
4. **Visualização:** Dashboard com histórico (lote, data, hora) e medições em tempo real
5. **Segurança:** Autenticação de usuários para acesso aos dados

### Não Funcionais
* **Resistência:** Sensores resistentes à umidade e corrosão para o ambiente marinho
* **Acessibilidade:** Interface web seguindo princípios de usabilidade
* **Disponibilidade:** Operação contínua durante todo o período de monitoramento

## 🏗️ Arquitetura e Tecnologias
* **Hardware:** Microcontroladores Arduino com sensores de temperatura e umidade
* **Interface:** Site institucional e Dashboard para visualização de dados
* **Back-end/Banco de Dados:** Sistema para tratamento e armazenamento de medições

## 📂 Escopo e Restrições
* **Foco Exclusivo:** O sistema é calibrado especificamente para a **Tilápia** e ambiente de **Containers Reefers**
* **Fora de Escopo:** Não inclui manutenção de motores de refrigeração, rastreamento de localização (GPS) ou monitoramento de outros tipos de carga
* **Premissas:** Necessário internet via satélite (min. 100 Mbps) e alimentação estável a bordo da embarcação

## 👥 Equipe Técnica
* Anderson Francisco Santos de Oliveira 
* Gabriel Vellenick Zanotti 
* Gus Kenzo Shigeoka Paulino 
* Gustavo Lima de Araujo 
* Luiz Carlos Duarte Silva 
* Marcus Brenno de Souza Lima 

---
