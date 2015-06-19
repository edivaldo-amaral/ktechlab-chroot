#!/bin/bash

#.........................................................
# Instalando o schroot
clear
echo
echo -e "\e[32m Verificando se o programa schroot está instalado \e[m"
echo -e "\e[33m ------------------------------------------------ \e[m"
sleep 2
nome=$(which schroot)
if [ -n "$nome" ] ;
then	echo
	echo -e "\e[36m O programa schroot já está instalado \e[m"
	sleep 1
else	echo
	echo -e "\e[36m Instalando o schroot \e[m"
	echo "apt-get install schroot -y"
	sleep 1
	apt-get install schroot -y
fi
sleep 1
#----------------------------------------------------------


#.........................................................
# Descompactando o lucid.tar.xz em /var/
clear
echo
echo -e "\e[32m Descompactando o lucid.tar.gz em /var/ \e[m"
echo -e "\e[33m ------------------------------------------------ \e[m"
sleep 2
tar -C /var/ -vxf lucid.tar.xz
sleep 2
#----------------------------------------------------------


#.........................................................
# Editando o arquivo /etc/fstab
clear
echo
echo -e "\e[32m Editando o arquivo /etc/fstab \e[m"
echo -e "\e[33m ------------------------------------------------ \e[m"
sleep 1
echo -e "\e[36m Inserindo o seguinte texto no final do fstab: \e[m"
sleep 1
echo -e "\e[34m
# Ubuntu 10.04 chroot ( ktechlabchroota )
/home /var/lucid/home none bind 0 0
/tmp /var/lucid/tmp none bind 0 0
/dev /var/lucid/dev none bind 0 0
/proc /var/lucid/proc none bind 0 0
/sys /var/lucid/sys none bind 0 0
#( ktechlabchrootb ) \e[m"
sleep 1
echo "
# Ubuntu 10.04 chroot ( ktechlabchroota )
/home /var/lucid/home none bind 0 0
/tmp /var/lucid/tmp none bind 0 0
/dev /var/lucid/dev none bind 0 0
/proc /var/lucid/proc none bind 0 0
/sys /var/lucid/sys none bind 0 0
#( ktechlabchrootb ) " >> /etc/fstab
sleep 1
#----------------------------------------------------------


#.........................................................
# Montando os diretórios
clear
echo
echo -e "\e[32m Montando diretórios \e[m"
echo -e "\e[33m ------------------------------------------------ \e[m"
sleep 1
echo -e "\e[36m Os seguintes diretórios serão montados: \e[m"
sleep 1
echo -e "\e[34m
mount /var/lucid/home
mount /var/lucid/tmp
mount /var/lucid/dev
mount /var/lucid/proc
mount /var/lucid/sys \e[m"
sleep 1
mount /var/lucid/home
mount /var/lucid/tmp
mount /var/lucid/dev
mount /var/lucid/proc
mount /var/lucid/sys
sleep 1
#----------------------------------------------------------


#.........................................................
# Configurando o schroot
clear
echo
echo -e "\e[32m Configurando o schroot \e[m"
echo -e "\e[33m ------------------------------------------------ \e[m"
sleep 1
echo -e "\e[36m Inserindo o seguinte texto no arquivo /etc/schroot/schroot.conf: \e[m"
sleep 1
echo -e "\e[34m
#( ktechlabchroota )
[lucid]
description=Ubuntu 10.04 i386
groups=users,root
root-groups=users,root
aliases=default,unstable,ia32
personality=linux32
directory=/var/lucid
root-users="$(logname)"
#( ktechlabchrootb ) \e[m"
sleep 1
echo "
#( ktechlabchroota )
[lucid]
description=Ubuntu 10.04 i386
groups=users,root
root-groups=users,root
aliases=default,unstable,ia32
personality=linux32
directory=/var/lucid
root-users="$(logname)"
#( ktechlabchrootb )" >> /etc/schroot/schroot.conf
#Insere o texto root-users com o nome do usuario atual
#echo "root-users="$(logname)" >> /etc/schroot/schroot.conf
sleep 1
#----------------------------------------------------------


#.........................................................
# Configurando os links
clear
echo
echo -e "\e[32m Configurando link simbolico para o ktechlab \e[m"
echo -e "\e[33m ------------------------------------------------ \e[m"
sleep 2

echo -e "\e[36m Criando um arquivo de texto chamado do_chroot em /usr/local/bin/ \e[m"
sleep 1
#Criando o arquivo de texto chamado "do_chroot"
touch /usr/local/bin/do_chroot

echo
echo -e "\e[36m Inserindo o seguinte texto no arquivo criado: \e[m"
sleep 1
echo -e "\e[34m
#!/bin/bash
exec schroot -p -c lucid -q -- \"\`basename \$0\`\" \"\$@\" \e[m"
sleep 1
#Inserindo o texto no arquivo criado:
echo "#!/bin/bash
exec schroot -p -c lucid -q -- \"\`basename \$0\`\" \"\$@\"" >> /usr/local/bin/do_chroot
sleep 1

echo
echo -e "\e[36m Tornando o arquivo executavel... \e[m"
sleep 1
chmod 755 /usr/local/bin/do_chroot

echo -e "\e[36m Criando o link simbolico para ktechlab \e[m"
sleep 1
ln -s /usr/local/bin/do_chroot /usr/local/bin/ktechlab

echo
echo -e "\e[36m Criando um icone em /usr/share/applications/ \e[m"
sleep 1
#Criando o arquivo de texto chamado "do_chroot"
touch /usr/share/applications/ktechlab.desktop

echo
echo -e "\e[36m Inserindo o seguinte texto no icone criado: \e[m"
sleep 1
echo -e "\e[34m
[Desktop Entry]
Version=1.0
Name=ktechlab
# Only KDE 4 seems to use GenericName, so we reuse the KDE strings.
# From Ubuntu's language-pack-kde-XX-base packages, version 9.04-20090413.
GenericName=Simulador de circuito eletronico

Exec=ktechlab %f
Terminal=false
Icon=/var/lucid/usr/share/icons/hicolor/64x64/apps/ktechlab.png
Type=Application
Categories=Development
X-Ayatana-Desktop-Shortcuts=NewWindow

[NewWindow Shortcut Group]
Name=New Window
Exec=ktechlab -n
TargetEnvironment=Unity \e[m"
sleep 1
#Inserindo o texto no arquivo criado:
echo "[Desktop Entry]
Version=1.0
Name=ktechlab
# Only KDE 4 seems to use GenericName, so we reuse the KDE strings.
# From Ubuntu's language-pack-kde-XX-base packages, version 9.04-20090413.
GenericName=Simulador de circuito eletronico

Exec=ktechlab %f
Terminal=false
Icon=/var/lucid/usr/share/icons/hicolor/64x64/apps/ktechlab.png
Type=Application
Categories=Development
X-Ayatana-Desktop-Shortcuts=NewWindow

[NewWindow Shortcut Group]
Name=New Window
Exec=ktechlab -n
TargetEnvironment=Unity" >> /usr/share/applications/ktechlab.desktop
sleep 1
#----------------------------------------------------------


#.........................................................
# Fim
clear
echo
echo -e "\e[32m Concluido \e[m"
echo -e "\e[33m ------------------------------------------------ \e[m"
sleep 1
#----------------------------------------------------------



#Referencias

#Alterando a cor do texto
#http://www.vivaolinux.com.br/artigo/Formatando-o-bash-com-cores-e-efeitos
#https://daemoniolabs.wordpress.com/2013/08/14/cores-em-shell-scripts-sem-caracteres-escapes-com-tput/



