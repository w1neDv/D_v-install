#!/data/data/com.termux/files/usr/bin/bash

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                    INSTALADOR DV - TERMUX                            ║
# ║         Personalización Completa de Terminal Android                 ║
# ╚══════════════════════════════════════════════════════════════════════╝

set -e

# ═══════════════════════════════════════════════════════════════════════
# PALETA DE COLORES
# ═══════════════════════════════════════════════════════════════════════

BLK='\033[0;30m'
RED='\033[0;31m'
GRN='\033[0;32m'
YLW='\033[0;33m'
BLU='\033[0;34m'
MGT='\033[0;35m'
CYN='\033[0;36m'
WHT='\033[0;37m'

BRED='\033[1;31m'
BGRN='\033[1;32m'
BYLW='\033[1;33m'
BBLU='\033[1;34m'
BMGT='\033[1;35m'
BCYN='\033[1;36m'
BWHT='\033[1;37m'

BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

TOTAL_HERRAMIENTAS=0
HERRAMIENTAS_INSTALADAS=0
LOG_FILE="$HOME/.dv_installer.log"
ERR_FILE="$HOME/.dv_installer.err"

declare -a HERRAMIENTAS=(
    "git" "curl" "wget" "nano" "vim" "neovim" "micro"
    "python" "python-pip" "nodejs" "clang" "make" "cmake"
    "zip" "unzip" "tar" "tree" "zsh" "figlet" "toilet"
    "cmatrix" "neofetch" "nmap" "netcat-openbsd" "openssh"
    "fzf" "fd" "ripgrep" "bat" "exa" "htop" "tmux"
    "ranger" "ffmpeg" "imagemagick" "golang"
)

TOTAL_HERRAMIENTAS=${#HERRAMIENTAS[@]}

limpiar_pantalla() { clear; }
esperar() { sleep "$1"; }

mostrar_logo() {
    limpiar_pantalla
    local colores=("$RED" "$YLW" "$GRN" "$CYN" "$BLU" "$MGT")
    echo ""; echo ""
    printf "${colores[0]}██████╗ ${NC}"
    printf "${colores[1]}██╗███╗   ██╗███████╗████████╗ █████╗ ██╗      █████╗ ██████╗ ${NC}"
    printf "${colores[2]}██╗   ██╗${NC}\n"
    printf "${colores[0]}██╔══██╗${NC}"
    printf "${colores[1]}██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██╔══██╗██╔══██╗${NC}"
    printf "${colores[2]}██║   ██║${NC}\n"
    printf "${colores[0]}██║  ██║${NC}"
    printf "${colores[1]}██║██╔██╗ ██║███████╗   ██║   ███████║██║     ███████║██████╔╝${NC}"
    printf "${colores[2]}██║   ██║${NC}\n"
    printf "${colores[0]}██║  ██║${NC}"
    printf "${colores[1]}██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██╔══██║██╔══██╗${NC}"
    printf "${colores[2]}╚██╗ ██╔╝${NC}\n"
    printf "${colores[0]}██████╔╝${NC}"
    printf "${colores[1]}██║██║ ╚████║███████║   ██║   ██║  ██║███████╗██║  ██║██║  ██║${NC}"
    printf "${colores[2]} ╚████╔╝ ${NC}\n"
    printf "${colores[0]}╚═════╝ ${NC}"
    printf "${colores[1]}╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝${NC}"
    printf "${colores[2]}  ╚═══╝  ${NC}\n"
    echo ""
    local subtitulo="TERMINAL ANDROID POWERED"
    local len=${#subtitulo}
    printf "                    "
    for ((i=0; i<len; i++)); do
        local color_idx=$((i % 6))
        printf "${colores[$color_idx]}%s${NC}" "${subtitulo:$i:1}"
    done
    echo ""; echo ""
    printf "${CYN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    echo ""
    esperar 2
}

mostrar_logo_silencioso() {
    local colores=("$RED" "$YLW" "$GRN" "$CYN" "$BLU" "$MGT")
    echo ""
    printf "${colores[0]}██████╗ ${NC}"
    printf "${colores[1]}██╗███╗   ██╗███████╗████████╗ █████╗ ██╗      █████╗ ██████╗ ${NC}"
    printf "${colores[2]}██╗   ██╗${NC}\n"
    printf "${colores[0]}██╔══██╗${NC}"
    printf "${colores[1]}██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██╔══██╗██╔══██╗${NC}"
    printf "${colores[2]}██║   ██║${NC}\n"
    printf "${colores[0]}██║  ██║${NC}"
    printf "${colores[1]}██║██╔██╗ ██║███████╗   ██║   ███████║██║     ███████║██████╔╝${NC}"
    printf "${colores[2]}██║   ██║${NC}\n"
    printf "${colores[0]}██║  ██║${NC}"
    printf "${colores[1]}██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██╔══██║██╔══██╗${NC}"
    printf "${colores[2]}╚██╗ ██╔╝${NC}\n"
    printf "${colores[0]}██████╔╝${NC}"
    printf "${colores[1]}██║██║ ╚████║███████║   ██║   ██║  ██║███████╗██║  ██║██║  ██║${NC}"
    printf "${colores[2]} ╚████╔╝ ${NC}\n"
    printf "${colores[0]}╚═════╝ ${NC}"
    printf "${colores[1]}╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝${NC}"
    printf "${colores[2]}  ╚═══╝  ${NC}\n"
    echo ""
    printf "${CYN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    echo ""
}

mostrar_info_telefono() {
    limpiar_pantalla
    mostrar_logo_silencioso
    echo ""
    printf "${BMGT}╔══════════════════════════════════════════════════════════════════════╗${NC}\n"
    printf "${BMGT}║${NC}          ${BWHT}${BOLD}📱 INFORMACIÓN DEL DISPOSITIVO${NC}          ${BMGT}║${NC}\n"
    printf "${BMGT}╚══════════════════════════════════════════════════════════════════════╝${NC}\n"
    echo ""
    
    local modelo=$(getprop ro.product.model 2>/dev/null || echo "Desconocido")
    local fabricante=$(getprop ro.product.manufacturer 2>/dev/null || echo "Desconocido")
    local android_version=$(getprop ro.build.version.release 2>/dev/null || echo "Desconocido")
    local sdk=$(getprop ro.build.version.sdk 2>/dev/null || echo "Desconocido")
    local kernel=$(uname -r)
    local arquitectura=$(uname -m)
    local hostname=$(hostname)
    local usuario=$(whoami)
    local fecha=$(date '+%d/%m/%Y %H:%M:%S')
    local zona_horaria=$(date +%Z)
    
    local mem_total="N/A"
    local mem_disp="N/A"
    if [ -f /proc/meminfo ]; then
        mem_total=$(cat /proc/meminfo | grep MemTotal | awk '{printf "%.1f GB", $2/1024/1024}')
        mem_disp=$(cat /proc/meminfo | grep MemAvailable | awk '{printf "%.1f GB", $2/1024/1024}')
    fi
    
    local storage_total=$(df -h /data 2>/dev/null | tail -1 | awk '{print $2}')
    local storage_used=$(df -h /data 2>/dev/null | tail -1 | awk '{print $3}')
    local storage_free=$(df -h /data 2>/dev/null | tail -1 | awk '{print $4}')
    local storage_pct=$(df -h /data 2>/dev/null | tail -1 | awk '{print $5}')
    
    local bateria_pct="N/A"
    local bateria_estado="N/A"
    if command -v termux-battery-status &>/dev/null; then
        bateria_pct=$(termux-battery-status 2>/dev/null | grep percentage | cut -d: -f2 | tr -d ' ,' || echo "N/A")
        bateria_estado=$(termux-battery-status 2>/dev/null | grep status | cut -d: -f2 | tr -d ' "' || echo "N/A")
    fi
    
    local ip_local="N/A"
    if command -v ifconfig &>/dev/null; then
        ip_local=$(ifconfig 2>/dev/null | grep "inet " | head -1 | awk '{print $2}' || echo "N/A")
    elif command -v ip &>/dev/null; then
        ip_local=$(ip addr show 2>/dev/null | grep 'inet ' | head -1 | awk '{print $2}' | cut -d/ -f1 || echo "N/A")
    fi
    
    printf "${MGT}  ┌─ ${BWHT}SISTEMA${NC}\n"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Modelo:        ${BWHT}%s${NC}\n" "$modelo"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Fabricante:    ${BWHT}%s${NC}\n" "$fabricante"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Android:       ${BWHT}%s (API %s)${NC}\n" "$android_version" "$sdk"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Kernel:        ${BWHT}%s${NC}\n" "$kernel"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Arquitectura:  ${BWHT}%s${NC}\n" "$arquitectura"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Hostname:      ${BWHT}%s${NC}\n" "$hostname"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Usuario:       ${BWHT}%s${NC}\n" "$usuario"
    echo ""
    printf "${MGT}  ┌─ ${BWHT}TIEMPO${NC}\n"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Fecha/Hora:    ${BWHT}%s${NC}\n" "$fecha"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Zona Horaria:  ${BWHT}%s${NC}\n" "$zona_horaria"
    echo ""
    printf "${MGT}  ┌─ ${BWHT}MEMORIA RAM${NC}\n"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Total:         ${BWHT}%s${NC}\n" "$mem_total"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Disponible:    ${BWHT}%s${NC}\n" "$mem_disp"
    echo ""
    printf "${MGT}  ┌─ ${BWHT}ALMACENAMIENTO${NC}\n"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Total:         ${BWHT}%s${NC}\n" "$storage_total"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Usado:         ${BWHT}%s (%s)${NC}\n" "$storage_used" "$storage_pct"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Libre:         ${BWHT}%s${NC}\n" "$storage_free"
    echo ""
    printf "${MGT}  ┌─ ${BWHT}BATERÍA${NC}\n"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Nivel:         ${BWHT}%s%%${NC}\n" "$bateria_pct"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Estado:        ${BWHT}%s${NC}\n" "$bateria_estado"
    echo ""
    printf "${MGT}  ┌─ ${BWHT}RED${NC}\n"
    printf "${MGT}  │${NC}  ${MGT}•${NC} IP Local:      ${BWHT}%s${NC}\n" "$ip_local"
    echo ""
    printf "${MGT}  ┌─ ${BWHT}TERMUX${NC}\n"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Versión:       ${BWHT}%s${NC}\n" "$(pkg --version 2>/dev/null || echo 'N/A')"
    printf "${MGT}  │${NC}  ${MGT}•${NC} Paquetes:      ${BWHT}%s${NC}\n" "$(pkg list-installed 2>/dev/null | wc -l)"
    echo ""
    printf "${MGT}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    echo ""
    esperar 3
}

actualizar_termux() {
    limpiar_pantalla
    mostrar_logo_silencioso
    echo ""
    printf "${BCYN}╔══════════════════════════════════════════════════════════════════════╗${NC}\n"
    printf "${BCYN}║${NC}           ${BWHT}${BOLD}🔄 ACTUALIZACIÓN DE REPOSITORIOS${NC}           ${BCYN}║${NC}\n"
    printf "${BCYN}╚══════════════════════════════════════════════════════════════════════╝${NC}\n"
    echo ""
    printf "${CYN}  ➤ Actualizando lista de paquetes...${NC}\n"
    pkg update -y >> "$LOG_FILE" 2>> "$ERR_FILE"
    printf "${CYN}  ➤ Actualizando paquetes instalados...${NC}\n"
    pkg upgrade -y >> "$LOG_FILE" 2>> "$ERR_FILE"
    echo ""
    printf "${BGRN}  ✓ Actualización completada exitosamente${NC}\n"
    echo ""
    printf "${CYN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    esperar 2
}

barra_progreso() {
    local actual=$1
    local total=$2
    local mensaje="${3:-Progreso}"
    local ancho=50
    if [ "$total" -eq 0 ]; then total=1; fi
    local porcentaje=$(( actual * 100 / total ))
    local completado=$(( actual * ancho / total ))
    local restante=$(( ancho - completado ))
    
    local color_barra=""
    if [ "$porcentaje" -lt 20 ]; then color_barra="$RED"
    elif [ "$porcentaje" -lt 40 ]; then color_barra="$YLW"
    elif [ "$porcentaje" -lt 60 ]; then color_barra="$GRN"
    elif [ "$porcentaje" -lt 80 ]; then color_barra="$CYN"
    else color_barra="$BLU"; fi
    
    printf "\r"
    printf "${BWHT}  %-25s ${NC}" "$mensaje"
    printf "${color_barra}▕${NC}"
    
    for ((i=0; i<completado; i++)); do
        local char_idx=$((i % 4))
        case $char_idx in
            0) printf "${color_barra}█${NC}" ;;
            1) printf "${color_barra}▓${NC}" ;;
            2) printf "${color_barra}▒${NC}" ;;
            3) printf "${color_barra}░${NC}" ;;
        esac
    done
    
    for ((i=0; i<restante; i++)); do printf "${DIM}·${NC}"; done
    printf "${color_barra}▏${NC} "
    
    if [ "$porcentaje" -eq 100 ]; then
        printf "${BGRN}%3d%%${NC}" "$porcentaje"
    else
        printf "${color_barra}%3d%%${NC}" "$porcentaje"
    fi
}

mostrar_menu_herramientas() {
    limpiar_pantalla
    mostrar_logo_silencioso
    echo ""
    printf "${BYLW}╔══════════════════════════════════════════════════════════════════════╗${NC}\n"
    printf "${BYLW}║${NC}        ${BWHT}${BOLD}📦 HERRAMIENTAS A INSTALAR${NC}        ${BYLW}║${NC}\n"
    printf "${BYLW}╚══════════════════════════════════════════════════════════════════════╝${NC}\n"
    echo ""
    printf "${YLW}  Se instalarán las siguientes ${BWHT}%d${NC}${YLW} herramientas:${NC}\n" "$TOTAL_HERRAMIENTAS"
    echo ""
    
    local count=0
    local cols=3
    local col_width=25
    printf "  "
    
    for herramienta in "${HERRAMIENTAS[@]}"; do
        local color_idx=$((count % 6))
        local colores=("$RED" "$YLW" "$GRN" "$CYN" "$BLU" "$MGT")
        printf "${colores[$color_idx]}%-${col_width}s${NC}" "• $herramienta"
        count=$((count + 1))
        if [ $((count % cols)) -eq 0 ]; then
            echo ""
            printf "  "
        fi
    done
    
    if [ $((count % cols)) -ne 0 ]; then echo ""; fi
    echo ""
    printf "${CYN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    echo ""
    
    while true; do
        printf "${BWHT}  ¿Deseas continuar con la instalación? ${NC}"
        printf "${BGRN}[S]${NC}${BWHT} para continuar${NC} ${BRED}[N]${NC}${BWHT} para cancelar: ${NC}"
        read -r respuesta
        
        case "$respuesta" in
            [Ss]*|[Ss][Ii]*)
                printf "\n${BGRN}  ✓ Iniciando instalación...${NC}\n"
                esperar 1
                return 0
                ;;
            [Nn]*)
                printf "\n${BRED}  ✗ Instalación cancelada por el usuario${NC}\n"
                echo ""
                printf "${CYN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
                esperar 2
                exit 0
                ;;
            *)
                printf "\n${BYLW}  ⚠ Por favor responde S para continuar o N para cancelar${NC}\n\n"
                ;;
        esac
    done
}

instalar_herramientas() {
    limpiar_pantalla
    mostrar_logo_silencioso
    echo ""
    printf "${BGRN}╔══════════════════════════════════════════════════════════════════════╗${NC}\n"
    printf "${BGRN}║${NC}           ${BWHT}${BOLD}🔧 INSTALANDO HERRAMIENTAS${NC}           ${BGRN}║${NC}\n"
    printf "${BGRN}╚══════════════════════════════════════════════════════════════════════╝${NC}\n"
    echo ""
    
    local total=${#HERRAMIENTAS[@]}
    local actual=0
    local exitosas=0
    local fallidas=0
    
    for herramienta in "${HERRAMIENTAS[@]}"; do
        actual=$((actual + 1))
        
        if dpkg -l "$herramienta" &>/dev/null || command -v "$herramienta" &>/dev/null; then
            printf "\n${BYLW}  ⚡ %s ya está instalado, omitiendo...${NC}\n" "$herramienta"
            exitosas=$((exitosas + 1))
            barra_progreso "$actual" "$total" "Instalando"
            continue
        fi
        
        printf "\n${BCYN}  📦 Instalando ${BWHT}%s${NC}${BCYN} (%d/%d)...${NC}\n" "$herramienta" "$actual" "$total"
        
        if pkg install -y "$herramienta" >> "$LOG_FILE" 2>> "$ERR_FILE"; then
            printf "${BGRN}  ✓ %s instalado correctamente${NC}\n" "$herramienta"
            exitosas=$((exitosas + 1))
        else
            printf "${BRED}  ✗ Error al instalar %s${NC}\n" "$herramienta"
            fallidas=$((fallidas + 1))
        fi
        
        barra_progreso "$actual" "$total" "Instalando"
        esperar 0.3
    done
    
    printf "\n\n"
    printf "${CYN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    echo ""
    printf "${BGRN}  ✓ Instalación completada:${NC}\n"
    printf "${GRN}    • Exitosas: %d${NC}\n" "$exitosas"
    if [ "$fallidas" -gt 0 ]; then
        printf "${RED}    • Fallidas: %d${NC}\n" "$fallidas"
    fi
    echo ""
    HERRAMIENTAS_INSTALADAS=$exitosas
    esperar 2
}

verificar_interacciones() {
    limpiar_pantalla
    mostrar_logo_silencioso
    echo ""
    printf "${BYLW}╔══════════════════════════════════════════════════════════════════════╗${NC}\n"
    printf "${BYLW}║${NC}        ${BWHT}${BOLD}🔔 VERIFICACIÓN DE CONFIGURACIONES${NC}        ${BYLW}║${NC}\n"
    printf "${BYLW}╚══════════════════════════════════════════════════════════════════════╝${NC}\n"
    echo ""
    
    if command -v zsh &>/dev/null; then
        printf "${CYN}  ➤ Se detectó Zsh instalado${NC}\n"
        if [ ! -d "$HOME/.oh-my-zsh" ]; then
            printf "${BYLW}  ⚠ Oh-My-Zsh no está configurado${NC}\n"
            while true; do
                printf "${BWHT}  ¿Deseas instalar Oh-My-Zsh? ${BGRN}[S]${NC}${BWHT}/${BRED}[N]${NC}: ${NC}"
                read -r resp
                case "$resp" in
                    [Ss]*)
                        printf "\n${CYN}  ➤ Instalando Oh-My-Zsh...${NC}\n"
                        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended >> "$LOG_FILE" 2>> "$ERR_FILE" || true
                        printf "${BGRN}  ✓ Oh-My-Zsh instalado${NC}\n"
                        break
                        ;;
                    [Nn]*)
                        printf "${BYLW}  ⏭ Omitiendo Oh-My-Zsh${NC}\n"
                        break
                        ;;
                    *)
                        printf "${BYLW}  ⚠ Responde S o N${NC}\n"
                        ;;
                esac
            done
        fi
    fi
    
    if [ ! -d "$HOME/storage" ]; then
        printf "\n${CYN}  ➤ Acceso al almacenamiento no configurado${NC}\n"
        while true; do
            printf "${BWHT}  ¿Configurar acceso a /sdcard? ${BGRN}[S]${NC}${BWHT}/${BRED}[N]${NC}: ${NC}"
            read -r resp
            case "$resp" in
                [Ss]*)
                    printf "\n${CYN}  ➤ Configurando almacenamiento...${NC}\n"
                    termux-setup-storage
                    printf "${BGRN}  ✓ Almacenamiento configurado${NC}\n"
                    break
                    ;;
                [Nn]*)
                    printf "${BYLW}  ⏭ Omitiendo configuración de almacenamiento${NC}\n"
                    break
                    ;;
                *)
                    printf "${BYLW}  ⚠ Responde S o N${NC}\n"
                    ;;
            esac
        done
    fi
    
    if command -v pip &>/dev/null; then
        printf "\n${CYN}  ➤ Actualizando pip...${NC}\n"
        pip install --upgrade pip >> "$LOG_FILE" 2>> "$ERR_FILE" || true
        printf "${BGRN}  ✓ Pip actualizado${NC}\n"
    fi
    
    echo ""
    printf "${CYN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    esperar 2
}

instalacion_finalizada() {
    limpiar_pantalla
    local colores=("$RED" "$YLW" "$GRN" "$CYN" "$BLU" "$MGT")
    echo ""; echo ""
    printf "${colores[0]}██████╗ ${NC}"
    printf "${colores[1]}██╗███╗   ██╗███████╗████████╗ █████╗ ██╗      █████╗ ██████╗ ${NC}"
    printf "${colores[2]}██╗   ██╗${NC}\n"
    printf "${colores[0]}██╔══██╗${NC}"
    printf "${colores[1]}██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██╔══██╗██╔══██╗${NC}"
    printf "${colores[2]}██║   ██║${NC}\n"
    printf "${colores[0]}██║  ██║${NC}"
    printf "${colores[1]}██║██╔██╗ ██║███████╗   ██║   ███████║██║     ███████║██████╔╝${NC}"
    printf "${colores[2]}██║   ██║${NC}\n"
    printf "${colores[0]}██║  ██║${NC}"
    printf "${colores[1]}██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██╔══██║██╔══██╗${NC}"
    printf "${colores[2]}╚██╗ ██╔╝${NC}\n"
    printf "${colores[0]}██████╔╝${NC}"
    printf "${colores[1]}██║██║ ╚████║███████║   ██║   ██║  ██║███████╗██║  ██║██║  ██║${NC}"
    printf "${colores[2]} ╚████╔╝ ${NC}\n"
    printf "${colores[0]}╚═════╝ ${NC}"
    printf "${colores[1]}╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝${NC}"
    printf "${colores[2]}  ╚═══╝  ${NC}\n"
    echo ""
    
    printf "${BGRN}╔══════════════════════════════════════════════════════════════════════╗${NC}\n"
    printf "${BGRN}║${NC}                                                                    ${BGRN}║${NC}\n"
    printf "${BGRN}║${NC}     ${BWHT}${BOLD}🎉  ¡INSTALACIÓN FINALIZADA EXITOSAMENTE!  🎉${NC}     ${BGRN}║${NC}\n"
    printf "${BGRN}║${NC}                                                                    ${BGRN}║${NC}\n"
    printf "${BGRN}╚══════════════════════════════════════════════════════════════════════╝${NC}\n"
    echo ""
    
    printf "${CYN}  📊 RESUMEN DE LA INSTALACIÓN:${NC}\n"
    echo ""
    printf "${GRN}  ✓ Herramientas instaladas: ${BWHT}%d${NC}\n" "$HERRAMIENTAS_INSTALADAS"
    printf "${GRN}  ✓ Total procesado: ${BWHT}%d${NC}\n" "$TOTAL_HERRAMIENTAS"
    printf "${YLW}  ⏱ Tiempo de ejecución: ${BWHT}%s${NC}\n" "$(date '+%H:%M:%S')"
    echo ""
    
    printf "${CYN}  📁 Archivos de log:${NC}\n"
    printf "${BLU}    • Log: ${BWHT}%s${NC}\n" "$LOG_FILE"
    printf "${BLU}    • Errores: ${BWHT}%s${NC}\n" "$ERR_FILE"
    echo ""
    
    printf "${CYN}  🛠️  HERRAMIENTAS DESTACADAS:${NC}\n"
    echo ""
    printf "    ${GRN}neovim${NC}:${WHT} Editor avanzado${NC}\n"
    printf "    ${CYN}micro${NC}:${WHT} Editor moderno${NC}\n"
    printf "    ${YLW}zsh${NC}:${WHT} Shell mejorado${NC}\n"
    printf "    ${BLU}tmux${NC}:${WHT} Multiplexor${NC}\n"
    printf "    ${MGT}fzf${NC}:${WHT} Buscador difuso${NC}\n"
    printf "    ${RED}nmap${NC}:${WHT} Escáner de red${NC}\n"
    printf "    ${GRN}python${NC}:${WHT} Desarrollo${NC}\n"
    printf "    ${CYN}nodejs${NC}:${WHT} JavaScript${NC}\n"
    echo ""
    printf "${BYLW}  💡 Consejo: ${NC}${WHT}Reinicia Termux para aplicar todos los cambios${NC}\n"
    echo ""
    printf "${CYN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    echo ""
    
    printf "${BWHT}  Abriendo menú principal"
    for i in {1..3}; do
        printf "${BWHT}.${NC}"
        esperar 0.5
    done
    echo ""; echo ""
    esperar 1
}

crear_menu() {
    mkdir -p "$HOME/.local/bin"
    
    cat > "$HOME/.local/bin/dv-menu" << 'MENUEOF'
#!/data/data/com.termux/files/usr/bin/bash

BLK='\033[0;30m'
RED='\033[0;31m'
GRN='\033[0;32m'
YLW='\033[0;33m'
BLU='\033[0;34m'
MGT='\033[0;35m'
CYN='\033[0;36m'
WHT='\033[0;37m'
BRED='\033[1;31m'
BGRN='\033[1;32m'
BYLW='\033[1;33m'
BBLU='\033[1;34m'
BMGT='\033[1;35m'
BCYN='\033[1;36m'
BWHT='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m'

limpiar() { clear; }

mostrar_banner() {
    limpiar
    local colores=("$RED" "$YLW" "$GRN" "$CYN" "$BLU" "$MGT")
    echo ""
    printf "${colores[0]}██████╗ ${NC}"
    printf "${colores[1]}██╗███╗   ██╗███████╗████████╗ █████╗ ██╗      █████╗ ██████╗ ${NC}"
    printf "${colores[2]}██╗   ██╗${NC}\n"
    printf "${colores[0]}██╔══██╗${NC}"
    printf "${colores[1]}██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██╔══██╗██╔══██╗${NC}"
    printf "${colores[2]}██║   ██║${NC}\n"
    printf "${colores[0]}██║  ██║${NC}"
    printf "${colores[1]}██║██╔██╗ ██║███████╗   ██║   ███████║██║     ███████║██████╔╝${NC}"
    printf "${colores[2]}██║   ██║${NC}\n"
    printf "${colores[0]}██║  ██║${NC}"
    printf "${colores[1]}██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██╔══██║██╔══██╗${NC}"
    printf "${colores[2]}╚██╗ ██╔╝${NC}\n"
    printf "${colores[0]}██████╔╝${NC}"
    printf "${colores[1]}██║██║ ╚████║███████║   ██║   ██║  ██║███████╗██║  ██║██║  ██║${NC}"
    printf "${colores[2]} ╚████╔╝ ${NC}\n"
    printf "${colores[0]}╚═════╝ ${NC}"
    printf "${colores[1]}╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝${NC}"
    printf "${colores[2]}  ╚═══╝  ${NC}\n"
    echo ""
    printf "${CYN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    echo ""
}

mostrar_menu() {
    mostrar_banner
    printf "${BWHT}${BOLD}  MENÚ PRINCIPAL${NC}\n"
    echo ""
    printf "${GRN}  [1]${NC} ${WHT}Información del sistema${NC}\n"
    printf "${CYN}  [2]${NC} ${WHT}Actualizar paquetes${NC}\n"
    printf "${YLW}  [3]${NC} ${WHT}Instalar herramienta adicional${NC}\n"
    printf "${BLU}  [4]${NC} ${WHT}Configurar Zsh / Oh-My-Zsh${NC}\n"
    printf "${MGT}  [5]${NC} ${WHT}Herramientas de red${NC}\n"
    printf "${RED}  [6]${NC} ${WHT}Servidor SSH${NC}\n"
    printf "${GRN}  [7]${NC} ${WHT}Backup de configuraciones${NC}\n"
    printf "${CYN}  [8]${NC} ${WHT}Limpiar sistema${NC}\n"
    printf "${BYLW}  [9]${NC} ${WHT}Abrir editor (Neovim)${NC}\n"
    printf "${BRED}  [0]${NC} ${WHT}Salir${NC}\n"
    echo ""
    printf "${CYN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    echo ""
}

info_sistema() {
    mostrar_banner
    printf "${BMGT}  📱 INFORMACIÓN DEL SISTEMA${NC}\n\n"
    printf "${MGT}  • Modelo: ${BWHT}%s${NC}\n" "$(getprop ro.product.model 2>/dev/null || echo 'N/A')"
    printf "${MGT}  • Android: ${BWHT}%s${NC}\n" "$(getprop ro.build.version.release 2>/dev/null || echo 'N/A')"
    printf "${MGT}  • Kernel: ${BWHT}%s${NC}\n" "$(uname -r)"
    printf "${MGT}  • Arquitectura: ${BWHT}%s${NC}\n" "$(uname -m)"
    printf "${MGT}  • Hostname: ${BWHT}%s${NC}\n" "$(hostname)"
    printf "${MGT}  • Uptime: ${BWHT}%s${NC}\n" "$(uptime | awk -F',' '{print $1}')"
    echo ""
    read -p "Presiona Enter para continuar..."
}

actualizar_paquetes() {
    mostrar_banner
    printf "${BCYN}  🔄 Actualizando paquetes...${NC}\n\n"
    pkg update -y && pkg upgrade -y
    echo ""
    printf "${BGRN}  ✓ Actualización completada${NC}\n"
    read -p "Presiona Enter para continuar..."
}

instalar_adicional() {
    mostrar_banner
    printf "${BYLW}  📦 Instalar herramienta adicional${NC}\n\n"
    read -p "Nombre de la herramienta: " herramienta
    if [ -n "$herramienta" ]; then
        pkg install -y "$herramienta"
    fi
    read -p "Presiona Enter para continuar..."
}

configurar_zsh() {
    mostrar_banner
    printf "${BCYN}  ⚙️  Configuración de Zsh${NC}\n\n"
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        printf "${BYLW}  Instalando Oh-My-Zsh...${NC}\n"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    printf "${BGRN}  ✓ Zsh configurado${NC}\n"
    printf "${BYLW}  Para cambiar a Zsh ejecuta: chsh -s zsh${NC}\n"
    read -p "Presiona Enter para continuar..."
}

herramientas_red() {
    mostrar_banner
    printf "${BMGT}  🌐 HERRAMIENTAS DE RED${NC}\n\n"
    printf "${CYN}  [1]${NC} ${WHT}Escanear red local (nmap)${NC}\n"
    printf "${CYN}  [2]${NC} ${WHT}Ver interfaces de red${NC}\n"
    printf "${CYN}  [3]${NC} ${WHT}Ping a host${NC}\n"
    printf "${CYN}  [0]${NC} ${WHT}Volver${NC}\n"
    echo ""
    read -p "Selecciona una opción: " op_red
    case "$op_red" in
        1) read -p "Rango de red (ej: 192.168.1.0/24): " rango
           nmap -sn "$rango" 2>/dev/null || printf "${BRED}Error ejecutando nmap${NC}\n" ;;
        2) ifconfig || ip addr ;;
        3) read -p "Host a hacer ping: " host
           ping -c 4 "$host" ;;
    esac
    read -p "Presiona Enter para continuar..."
}

servidor_ssh() {
    mostrar_banner
    printf "${BRED}  🔐 SERVIDOR SSH${NC}\n\n"
    printf "${CYN}  [1]${NC} ${WHT}Iniciar servidor SSH${NC}\n"
    printf "${CYN}  [2]${NC} ${WHT}Detener servidor SSH${NC}\n"
    printf "${CYN}  [3]${NC} ${WHT}Ver estado${NC}\n"
    printf "${CYN}  [0]${NC} ${WHT}Volver${NC}\n"
    echo ""
    read -p "Selecciona una opción: " op_ssh
    case "$op_ssh" in
        1) sshd
           printf "${BGRN}  ✓ Servidor SSH iniciado en puerto 8022${NC}\n"
           printf "${BYLW}  Tu IP: $(ifconfig | grep 'inet ' | head -1 | awk '{print $2}')${NC}\n" ;;
        2) pkill sshd 2>/dev/null
           printf "${BGRN}  ✓ Servidor SSH detenido${NC}\n" ;;
        3) if pgrep sshd > /dev/null; then
               printf "${BGRN}  ✓ SSH está activo${NC}\n"
           else
               printf "${BRED}  ✗ SSH está inactivo${NC}\n"
           fi ;;
    esac
    read -p "Presiona Enter para continuar..."
}

backup_config() {
    mostrar_banner
    printf "${BGRN}  💾 BACKUP DE CONFIGURACIONES${NC}\n\n"
    local backup_dir="/sdcard/Termux-Backups"
    local fecha=$(date +%Y%m%d_%H%M%S)
    local archivo="$backup_dir/termux_backup_$fecha.tar.gz"
    mkdir -p "$backup_dir"
    printf "${CYN}  Creando backup en:${NC}\n"
    printf "${BWHT}  %s${NC}\n" "$archivo"
    echo ""
    tar -czf "$archivo" -C /data/data/com.termux/files home usr/etc 2>/dev/null
    if [ -f "$archivo" ]; then
        printf "${BGRN}  ✓ Backup creado exitosamente${NC}\n"
        printf "${BYLW}  Tamaño: $(du -h "$archivo" | cut -f1)${NC}\n"
    else
        printf "${BRED}  ✗ Error al crear backup${NC}\n"
    fi
    read -p "Presiona Enter para continuar..."
}

limpiar_sistema() {
    mostrar_banner
    printf "${BYLW}  🧹 LIMPIEZA DEL SISTEMA${NC}\n\n"
    printf "${CYN}  → Limpiando caché de paquetes...${NC}\n"
    pkg clean
    printf "${CYN}  → Eliminando archivos temporales...${NC}\n"
    rm -rf /tmp/* 2>/dev/null
    rm -rf ~/.cache/* 2>/dev/null
    printf "${CYN}  → Optimizando base de datos...${NC}\n"
    pkg autoclean 2>/dev/null
    echo ""
    printf "${BGRN}  ✓ Sistema limpiado${NC}\n"
    read -p "Presiona Enter para continuar..."
}

abrir_editor() {
    if command -v nvim &>/dev/null; then nvim
    elif command -v micro &>/dev/null; then micro
    else nano; fi
}

while true; do
    mostrar_menu
    read -p "  Selecciona una opción: " opcion
    case "$opcion" in
        1) info_sistema ;;
        2) actualizar_paquetes ;;
        3) instalar_adicional ;;
        4) configurar_zsh ;;
        5) herramientas_red ;;
        6) servidor_ssh ;;
        7) backup_config ;;
        8) limpiar_sistema ;;
        9) abrir_editor ;;
        0) limpiar
           printf "${BGRN}  ¡Hasta luego! 👋${NC}\n\n"
           exit 0 ;;
        *) printf "${BRED}  Opción inválida${NC}\n"
           sleep 1 ;;
    esac
done
MENUEOF

    chmod +x "$HOME/.local/bin/dv-menu"
    if ! grep -q "$HOME/.local/bin" "$HOME/.bashrc" 2>/dev/null; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    fi
}

abrir_menu() {
    if [ -f "$HOME/.local/bin/dv-menu" ]; then
        exec "$HOME/.local/bin/dv-menu"
    else
        crear_menu
        exec "$HOME/.local/bin/dv-menu"
    fi
}

main() {
    touch "$LOG_FILE" "$ERR_FILE"
    mostrar_logo
    mostrar_info_telefono
    actualizar_termux
    mostrar_menu_herramientas
    instalar_herramientas
    verificar_interacciones
    instalacion_finalizada
    crear_menu
    abrir_menu
}

main "$@"

