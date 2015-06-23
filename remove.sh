#!/bin/bash

#.........................................................
# Removendo o ktechlab-chroot
clear
echo
echo -e "\e[32m Removendo o ktechlab-chroot \e[m"
echo -e "\e[33m ------------------------------------------------ \e[m"
sleep 2
#----------------------------------------------------------


#.........................................................
# Editando o arquivo /etc/fstab
clear
echo
echo -e "\e[32m Editando o arquivo /etc/fstab \e[m"
echo -e "\e[33m ------------------------------------------------ \e[m"
sleep 1
echo -e "\e[36m Removendo o seguinte texto no final do fstab: \e[m"
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
#Localizar e apagar a linha que tenha o texto "ktechlabchroota" até "ktechlabchrootb"
variavel=$(sed -e '/ktechlabchroota/,/ktechlabchrootb/d' /etc/fstab)
echo "$variavel" > /etc/fstab
sleep 1
sleep 1
#----------------------------------------------------------



#.........................................................
# Desmontando os diretórios
clear
echo
echo -e "\e[32m Desmontando diretorios \e[m"
echo -e "\e[33m ------------------------------------------------ \e[m"
sleep 1
echo -e "\e[36m Os seguintes diretórios serão desmontados: \e[m"
sleep 1
echo -e "\e[34m
umount /var/lucid/home
umount /var/lucid/tmp
umount /var/lucid/dev
umount /var/lucid/proc
umount /var/lucid/sys \e[m"
sleep 1
umount /var/lucid/home
umount /var/lucid/tmp
umount /var/lucid/dev
umount /var/lucid/proc
umount /var/lucid/sys
sleep 2
#----------------------------------------------------------


#.........................................................
# Configurando o schroot
clear
echo
echo -e "\e[32m Configurando o schroot \e[m"
echo -e "\e[33m ------------------------------------------------ \e[m"
sleep 1
echo -e "\e[36m Removendo o seguinte texto no arquivo /etc/schroot/schroot.conf: \e[m"
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
#Localizar e apagar a linha que tenha o texto "ktechlabchroota" até "ktechlabchrootb"
variavel=$(sed -e '/ktechlabchroota/,/ktechlabchrootb/d' /etc/schroot/schroot.conf)
echo "$variavel" > /etc/schroot/schroot.conf
sleep 1
#----------------------------------------------------------


#.........................................................
# Removendo os links
clear
echo
echo -e "\e[32m Removendo o link simbolico para o ktechlab \e[m"
echo -e "\e[33m ------------------------------------------------ \e[m"
sleep 2

echo -e "\e[36m Deletando do_chroot em /usr/local/bin/ \e[m"
sleep 1
#Criando o arquivo de texto chamado "do_chroot"
rm /usr/local/bin/do_chroot

echo
echo -e "\e[36m Deletando o link simbolico para ktechlab e ktechlab-gcb \e[m"
sleep 1
rm /usr/local/bin/ktechlab
rm /usr/local/bin/ktechlab-gcb

echo
echo -e "\e[36m Deletando o icone ktechlab.desktop e ktechlab-gcb.desktop em /usr/share/applications/ \e[m"
sleep 1
rm /usr/share/applications/ktechlab.desktop
rm /usr/share/applications/ktechlab-gcb.desktop
sleep 1
#----------------------------------------------------------


#----------------------------------------------------------
# Verificando se existe subdiretorios no diretorio /var/lucid/home
echo "Verificando se existe subdiretorios no diretorio /var/lucid/home/"
sleep 1
$echo find /var/lucid/home/* -type d 1> /dev/null 2> /dev/stdout # O trecho "1> /dev/null 2> /dev/stdout" oculta saida.
if [ "$?" -eq "0" ] ; then  # O comando "$?" serve para verificar de o ultimo comando deu certo (retornando "0")
	#SIM:
	#Entao nao faz nada! Pois, possivelmente, o diretorio /home ainda esta montado e 
	#isso podera apagar todos os dados do usuario.
	sleep 1
else
	#NAO:
	#.........................................................
	# Removendo o diretório /var/lucid
	clear
	echo
	echo -e "\e[32m Removendo diretorio /var/lucid \e[m"
	echo -e "\e[33m ------------------------------------------------ \e[m"
	sleep 2
	rm -r /var/lucid
	sleep 2

fi
#----------------------------------------------------------






#Referencias:

#comando para localizar uma linha no texto contente as palavras "uma" e "comando" e substitui as vogais "a" e "e" desta linha por "X"
#variavel=$(sed -e '/uma/,/comando/s/[ae]/X/g' texto2.txt)
#fonte: http://rberaldo.com.br/o-comando-sed-do-linux/
#fonte: http://hacklab.com.br/2013/07/18/sed-como-apagar-linhas/

#Localiza no texto a linha que contenha as palavras "uma" e "comando" e, em seguida, deleta esta linha.
#variavel=$(sed -e '/uma/,/comando/d' texto2.txt)

#Localizar e apagar a linha que tenha o texto "inicio" até "final"
#variavel=$(sed -e '/inicio/,/final/d' texto2.txt)


