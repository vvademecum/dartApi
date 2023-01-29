# Dart API Conduit
## Создание API при помощи пакета Conduit.

__Цель работы:__

Реализовать API при помощи пакета Conduit и реализовать функционал: регистрация, авторизация, "RefreshToken", вывод и редактирование данных пользователя, изменение пароля, CRUD действия для сущности "Note" (Заметка), поиск, пагинация, фильтрация, история действий и логическое удаление и восстановление записей.


__Ход работы:__ 

Подключаем `Conduit`, создаем `dockerfile` для подключения к БД, создаем сущности и реализовывем регистрацию:

<img width="251" alt="image" src="https://user-images.githubusercontent.com/59766395/215333666-50902489-c514-43b5-8879-311bdced69bc.png">

<img width="317" alt="Снимок экрана 2023-01-29 171900" src="https://user-images.githubusercontent.com/59766395/215333564-f3e9eac6-7bf5-470a-9c0a-4183ef5e1edd.png">


Запрос на регистрацию:

<img width="686" alt="image" src="https://user-images.githubusercontent.com/59766395/215333735-6c972cf6-6228-47e1-a3b7-37ec5e097e07.png">


Реализация авторизации:

<img width="312" alt="image" src="https://user-images.githubusercontent.com/59766395/215334005-9e155a0c-6b0f-40fd-89d5-10a48f14934f.png">


Запрос на авторизацию:

<img width="749" alt="image" src="https://user-images.githubusercontent.com/59766395/215334050-d3ad0a5d-ec65-43ad-b8c0-5cdce35477c6.png">


Реализация `RefreshToken`:

<img width="304" alt="image" src="https://user-images.githubusercontent.com/59766395/215334104-a1d36452-3619-4522-ae82-0d5b843572a7.png">


Реализация вывода данных пользователя и редактирование:

<img width="321" alt="image" src="https://user-images.githubusercontent.com/59766395/215334275-41b7b5a3-5515-4e4f-8249-49b150c2cf14.png">


Запрос на вывод данных пользователя и редактирование:

<img width="594" alt="image" src="https://user-images.githubusercontent.com/59766395/215334367-28a6344d-83df-4a22-a15f-1935aeb1b5d9.png">

<img width="596" alt="image" src="https://user-images.githubusercontent.com/59766395/215334416-712ae347-248b-4859-b4b5-19dd5b069153.png">


Реализация изменения пароля пользователя:

<img width="308" alt="image" src="https://user-images.githubusercontent.com/59766395/215334473-4b1133d7-5f71-4884-a58a-92b9c4764ac1.png">


Создаем сущность `Note` (Заметка) и реализовываем возможность доьавления новой заметки:

<img width="250" alt="image" src="https://user-images.githubusercontent.com/59766395/215334653-775321ce-2e66-465e-bb5f-19612f6e5345.png">

<img width="304" alt="image" src="https://user-images.githubusercontent.com/59766395/215334640-b24063ca-e2b2-4381-a6e6-3f8409085eb1.png">


Запрос на создание заметки:

<img width="701" alt="image" src="https://user-images.githubusercontent.com/59766395/215334796-846b7a47-8d40-4ff7-a308-c0d4c63dc14e.png">


Реализация функции вывода заметок с фильтрацией и пагинацией данных:

<img width="307" alt="image" src="https://user-images.githubusercontent.com/59766395/215334914-e9994bdf-8a9e-4b48-abcf-33aa6192b408.png">


Запрос на получение заметок с установленным параметром `limit` для ограничения кол-ва записей и `search` для поиска по наименованию заметки:

<img width="621" alt="image" src="https://user-images.githubusercontent.com/59766395/215335023-40ac5579-e6fc-4fe1-a946-5e86469fa029.png">

<img width="630" alt="image" src="https://user-images.githubusercontent.com/59766395/215335034-a7073efd-9674-4ca9-b1c9-ac28b81180a4.png">


Реализация логического удаления записи и запрос:

<img width="313" alt="image" src="https://user-images.githubusercontent.com/59766395/215335193-a31efd62-aab0-40fa-87d5-db578df1e6e5.png">

<img width="603" alt="image" src="https://user-images.githubusercontent.com/59766395/215335232-7ee660e5-6e7e-4003-8fa4-c1b625a2dea4.png">

<img width="633" alt="image" src="https://user-images.githubusercontent.com/59766395/215335256-62e933ad-2ce1-4288-8411-fa97fd513d32.png">


Восстановление записи c указанием параметра `reborn` - true:

<img width="623" alt="image" src="https://user-images.githubusercontent.com/59766395/215335427-566948ac-fb1b-4ae0-bc12-a063cbf5141a.png">

<img width="640" alt="image" src="https://user-images.githubusercontent.com/59766395/215335550-7d6c6816-2acd-473e-9853-b5a734e98bbe.png">


Реализация сущности `Hisotory` для хранения истории действий, реализация функции вывода истории действий:

<img width="299" alt="image" src="https://user-images.githubusercontent.com/59766395/215335637-ae75cb72-6b31-4eef-9106-d45f0eb66a74.png">

<img width="327" alt="image" src="https://user-images.githubusercontent.com/59766395/215335675-463180d7-aaf6-4912-bb81-3f469a3c9035.png">


Запрос на получение истории действий:

<img width="678" alt="image" src="https://user-images.githubusercontent.com/59766395/215335750-5b6a3f51-2527-4f4e-819b-665a34198a45.png">


__Вывод:__

В ходе практической работы было реализовано API при помощи пакета Conduit и реализован функционал: регистрация, авторизация, "RefreshToken", вывод и редактирование данных пользователя, изменение пароля, CRUD действия для сущности "Note" (Заметка), поиск, пагинация, фильтрация, история действий и логическое удаление и восстановление записей.
