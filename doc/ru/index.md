<!---
    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.
-->

# cordova-plugin-imagezoom

Этот плагин отображает и скрывает экран-заставку при запуске приложения.

## Установка

    cordova plugin add cordova-plugin-imagezoom
    

## Поддерживаемые платформы

*   Amazon Fire OS
*   Android
*   BlackBerry 10
*   iOS
*   Windows Phone 7 и 8
*   Windows 8

## Методы

*   imagezoom.show
*   imagezoom.hide

### Особенности Android

В вашем файле config.xml необходимо добавить следующие настройки:

`<preference name="ImageZoom" value="foo" />` `<preference name="ImageZoomDelay" value="10000" />`

Где foo это имя файла imagezoom, желательно 9 заплатку. Убедитесь в том добавить ваши splashcreen файлы в папку res/xml в соответствующие папки. Второй параметр представляет, как долго imagezoom появится в миллисекундах. По умолчанию он 3000 МС. Увидеть [иконки и заставки][1] для получения дополнительной информации.

 [1]: http://cordova.apache.org/docs/en/edge/config_ref_images.md.html

## imagezoom.hide

Закройте экран-заставка.

    Navigator.ImageZoom.Hide();
    

### Особенности BlackBerry 10, WP8, iOS

`config.xml`Файла `AutoHideImageZoom` должен быть `false` . Для задержки скрытия заставки на две секунды, добавить таймер, например в `deviceready` обработчик событий:

        setTimeout(function() {navigator.imagezoom.hide();
        }, 2000);
    

## imagezoom.show

Отображает экран-заставку.

    Navigator.ImageZoom.Show();
    

Ваше приложение не может вызвать `navigator.imagezoom.show()` до тех пор, пока приложение началась и `deviceready` событие инициировано. Но поскольку обычно экран-заставка должен быть видимым до начала вашего приложения, что казалось бы поражение цели экрана-заставки. Предоставление некоторых конфигурации в `config.xml` будет автоматически `show` экран-заставку сразу же после запуска вашего приложения и перед его полностью запущен и получил `deviceready` событие. Увидеть [иконки и заставки][1] для получения дополнительной информации на делать этой конфигурации. По этой причине маловероятно, вам нужно вызвать `navigator.imagezoom.show()` для отображения экрана-заставки для запуска приложения.
