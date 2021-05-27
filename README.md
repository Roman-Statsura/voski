# voski

Сайт проекта Таро Voski
Сайт сделан на MODX Revolution 2.8.1-pl

## Использование
1. Склонировать проект
2. Выгрузить БД с актуального сайта
3. Переименовать конфигурационные файлы MODX:
    - в корне example.config.core.php -> config.core.php
    - в папке manager example.config.core.php -> config.core.php
    - в папке core/config example.config.inc.php -> config.inc.php
    - в папке connectors example.config.core.php -> config.core.php
4. В конфигурационном файле в core/config/config.core.php изменить пути до актуальных путей директорий, также написать данные до БД
    Также внести изменения в файлы (необязательно, если потребуется)
    - /config.core.php
    - /connectors/config.core.php
    - /manager/config.core.php
5. Проставить права на следующие директории:
    - core/cache 777
    - core/components 777
    - core/elements 777
    - core/export 777
    - core/packages 777
    - assets/components 777

## Если сайт выдает ошибки или не пускает на сайт
Скачайте с сайта MODX Revolution 2.8.1-pl и пересите папку setup в корень вашего сайта и проведите повторную установку.
Таким образом, данный способ поможет обнаружить проблемы в переносе, он автоматически может проставить изменения в конфигурационных файлах.