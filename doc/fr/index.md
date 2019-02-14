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

Ce plugin affiche et masque un écran de démarrage lors du lancement de l'application.

## Installation

    cordova plugin add cordova-plugin-imagezoom
    

## Plates-formes prises en charge

*   Amazon Fire OS
*   Android
*   BlackBerry 10
*   iOS
*   Windows Phone 7 et 8
*   Windows 8

## Méthodes

*   imagezoom.Show
*   imagezoom.Hide

### Quirks Android

Dans votre fichier config.xml, vous devez ajouter les préférences suivantes :

    <preference name="ImageZoom" value="foo" />
    <preference name="ImageZoomDelay" value="10000" />
    

Où foo est le nom du fichier imagezoom, préférablement un fichier de 9 correctif. Assurez-vous d'ajouter vos fichiers splashcreen dans votre répertoire res/xml dans les dossiers appropriés. Le deuxième paramètre représente combien de temps le imagezoom apparaîtra en millisecondes. Il est par défaut à 3000 ms. Pour plus d'informations, consultez [icônes et écrans de démarrage][1].

 [1]: http://cordova.apache.org/docs/en/edge/config_ref_images.md.html

## imagezoom.Hide

Faire disparaître de l'écran de démarrage.

    navigator.imagezoom.hide();
    

### BlackBerry 10, WP8, iOS Quirk

Paramètre `AutoHideImageZoom` du fichier `config.xml` doit avoir la valeur `false`. Pour retarder la cacher l'écran de démarrage pendant deux secondes, ajouter un minuteur semblable à la suivante dans le gestionnaire d'événements `deviceready` :

        setTimeout(function() {
            navigator.imagezoom.hide();
        }, 2000);
    

## imagezoom.Show

Affiche l'écran de démarrage.

    navigator.imagezoom.show();
    

Votre application ne peut pas appeler `navigator.imagezoom.show()` jusqu'à ce que l'application a commencé et l'événement `deviceready` est déclenché. Mais puisqu'en général, l'écran de démarrage est destiné à être visible avant que votre application a commencé, qui semblerait à l'encontre des objectifs de l'écran de démarrage. Fournir une configuration dans le fichier `config.xml` automatiquement `show` le splash projettera immédiatement après votre lancement de l'app et avant qu'il a complètement démarré et a reçu l'événement `deviceready`. Voir les [icônes et les écrans de démarrage][1] pour plus d'informations sur la conduite de cette configuration. Pour cette raison, il est peu probable que vous devez appeler `navigator.imagezoom.show()` pour rendre l'écran de démarrage visible pour le démarrage de l'application.
