#!/usr/bin/env bash

set -euo pipefail

usage() {
	echo "Использование: $0 <log_directory> <days>"
	echo
	echo "Аргументы:"
	echo "log_directory	Путь к директории с лог файлами"
	echo "days		Удалять лог файлы старше этого значения"
	exit 1
}

if [[ $# -ne 2 ]]; then
	usage
fi

LOG_DIR="$1"
DAYS="$2"

if [[ ! -d "$LOG_DIR" ]]; then
	echo "Error: Директории не существует: $LOG_DIR"
	exit 1
fi

if ! [[ "$DAYS" =~ ^[0-9]+$ ]]; then
	echo "Error: аргумент days должен быть положительным числом"
	exit 1
fi

mapfile -t FILES < <(find "$LOG_DIR" -type f -name "*.log" -mtime +"$DAYS")

if [[ ${#FILES[@]} -eq 0 ]]; then
	echo "Лог файлов старше $DAYS не обнаружено"
	exit 0
fi

echo "Данные файлы будут удалены:"
for file in "${FILES[@]}"; do
	echo " $file"
done

echo
read -rp "Удалить эти файлы? (y/n): " CONFIRM

case "$CONFIRM" in
	y|Y)
		rm -f "${FILES[@]}"
		echo "Файлы удалены"
		;;
	n|N)
		echo "Операция отменена"
		;;
	*)
		echo "Неправильный ввод. Введите 'y' или 'n'"
		exit 1
		;;
esac

