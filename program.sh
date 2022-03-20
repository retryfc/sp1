#!/bin/bash
echo "Название программы: Программа проверки доступа"
echo "Назначение: Данная программа определяет осуществление доступа к файлам по дате"
echo "Автор: Перминов Дмитрий"

mydir="$(pwd)"
echo "Текущий каталог: $mydir"
is_empty=$(ls $mydir)
if [ "$is_empty" = "" ]
then
echo "dir: каталог пуст" >&2
exit 1
fi

is_exit=0
while [ $is_exit -eq 0 ]
do
echo "Введите имя файла в данном каталоге"
read filename
full_path="$mydir/$filename"
if ! [ -e $full_path ]
then
echo "file: неверное имя файла или файл не существует" >&2
continue
fi

is_continue=0
while [ $is_continue -eq 0 ]
do
echo "Введите дату в формате yyyy-mm-dd"
read read_date
if [ $(date -d $read_date +'%Y%m%d') ]
then
date=$(date -d $read_date +'%Y%m%d')
file_date=$(date -r $full_path +'%Y%m%d')
is_continue=1
fi
done

if [ $date -lt $file_date ]
then
echo "К файлу $filename осуществлялся доступ после $read_date"
else
exit 120
fi

is_continue=0
while [ $is_continue -eq 0 ]
do
echo "Продолжить? (y/n)"
read yn
case "$yn" in
[nN]) is_exit=1
is_continue=1 ;;
[yY]) is_continue=1 ;;
*) echo "Неправильная команда" >&2 ;;
esac
done
done
