#!/bin/bash

# Встановіть тут поріг використання дискового простору в відсотках
THRESHOLD=${THRESHOLD:-50}

# Отримання відсотка використання кореневого файлового системи (/)
USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

# Перевірка чи використання перевищує поріг
if [ "$USAGE" -ge "$THRESHOLD" ]; then
  # Запис повідомлення до файлу журналу
  echo "$(date): Warning - Disk usage on / is at ${USAGE}% which exceeds the threshold of ${THRESHOLD}%." >> /var/log/disk.log
fi

