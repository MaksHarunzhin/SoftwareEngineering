workspace {
    name "Система управления медицинскими записями"

    # включаем режим с иерархической системой идентификаторов
    !identifiers hierarchical

    model {
        properties { 
            structurizr.groupSeparator "/"
            workspace_cmdb "cmdb_mnemonic"
            architect "имя архитектора"
        }

        doctor    = person "Врач"
        admin   = person "Администратор системы"
        support = person "Специалист ТП"
        patient = person "Пациент"

        epush = softwareSystem "Система уведомлений" {
            -> patient "Уведомляет о предстоящей записи"
        }
        epic = softwareSystem "EPIC" {
            -> epush
        }
        emias = softwareSystem "ЕМИАС" {
            -> epic "Получает записи"
        }

        admin -> epic "Создание нового пользователя"
        doctor -> epic "Регистрация пациента"
        doctor -> epic "Создание медицинской записи"
        doctor -> epic "Добавление записи к пациенту"
    }

    views {
        # Конфигурируем настройки отображения plant uml
        properties {
            plantuml.format     "svg"
            kroki.format        "svg"
            structurizr.sort created
            structurizr.tooltips true
        }
        # Задаем стили для отображения
        themes default
        # Диаграмма контекста
        systemContext epic {
            include *
            autoLayout
        }
    }
}