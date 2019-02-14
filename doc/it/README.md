<!--
# license: Licensed to the Apache Software Foundation (ASF) under one
#         or more contributor license agreements.  See the NOTICE file
#         distributed with this work for additional information
#         regarding copyright ownership.  The ASF licenses this file
#         to you under the Apache License, Version 2.0 (the
#         "License"); you may not use this file except in compliance
#         with the License.  You may obtain a copy of the License at
#
#           http://www.apache.org/licenses/LICENSE-2.0
#
#         Unless required by applicable law or agreed to in writing,
#         software distributed under the License is distributed on an
#         "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#         KIND, either express or implied.  See the License for the
#         specific language governing permissions and limitations
#         under the License.
-->

# cordova-plugin-imagezoom

[![Build Status](https://travis-ci.org/apache/cordova-plugin-imagezoom.svg)](https://travis-ci.org/apache/cordova-plugin-imagezoom)

Questo plugin Visualizza e nasconde una schermata iniziale durante l'avvio dell'applicazione.

## Installazione

    // npm hosted (new) id
    cordova plugin add cordova-plugin-imagezoom
    // you may also install directly from this repo
    cordova plugin add https://github.com/apache/cordova-plugin-imagezoom.git
    

## Piattaforme supportate

  * Amazon fuoco OS
  * Android
  * BlackBerry 10
  * iOS
  * Windows Phone 7 e 8
  * Windows 8
  * Windows
  * Browser

## Metodi

  * imagezoom
  * imagezoom.Hide

### Stranezze Android

Nel vostro `config. XML`, è necessario aggiungere le seguenti preferenze:

    <preference name="ImageZoom" value="foo" />
    <preference name="ImageZoomDelay" value="10000" />
    <preference name="SplashMaintainAspectRatio" value="true|false" />
    

Dove foo è il nome del file imagezoom, preferibilmente un file 9 patch. Assicurati di aggiungere i tuoi file splashcreen res/xml nella directory sotto cartelle appropriate. Il secondo parametro rappresenta quanto tempo lo imagezoom apparirà in millisecondi. Il valore predefinito è 3000 ms. Per ulteriori informazioni, vedere [icone e schermate iniziali](http://cordova.apache.org/docs/en/edge/config_ref_images.md.html).

"SplashMaintainAspectRatio" preferenza è facoltativo. Se impostato su true, schermata iniziale drawable non viene adattata per misura lo schermo, ma invece semplicemente "copre" lo schermo, come CSS "sfondo-dimensione: copertina". Questo è molto utile quando immagini schermata iniziale non possono essere distorta in qualche modo, per esempio quando contengono testo o scenario. Questa impostazione funziona meglio con immagini che hanno grandi margini (zone sicure) che possono essere ritagliati in modo sicuro su schermi con proporzioni diverse.

Il plugin viene ricaricata splash drawable ogni volta che cambia orientamento, è possibile specificare diversi parte per orientamento verticale e orizzontale.

### Stranezze browser

Nel vostro `config. XML`, è possibile utilizzare le seguenti preferenze:

    <platform name="browser">
        <preference name="ImageZoom" value="images/browser/imagezoom.jpg" /> <!-- defaults to "img/logo.png" -->
        <preference name="ImageZoomDelay" value="10000" /> <!-- defaults to "3000" -->
        <preference name="ImageZoomBackgroundColor" value="green" /> <!-- defaults to "#464646" -->
        <preference name="ShowImageZoom" value="false" /> <!-- defaults to "true" -->
        <preference name="ImageZoomWidth" value="600" /> <!-- defaults to "170" -->
        <preference name="ImageZoomHeight" value="300" /> <!-- defaults to "200" -->
    </platform>
    

### iOS stranezze

  * `FadeImageZoom` (boolean, impostazioni predefinite a `true`): impostare su `false` per impedire che la schermata iniziale e scompaiono quando cambia il relativo stato di visualizzazione.
    
        <preference name="FadeImageZoom" value="false"/>
        

  * `FadeImageZoomDuration` (float, il valore predefinito è `2`): specifica il numero di secondi per la schermata iniziale dissolvenza effetto da eseguire.
    
        <preference name="FadeImageZoomDuration" value="4"/>
        

  * `ShowImageZoomSpinner` (boolean, impostazioni predefinite a `true`): impostare su `false` per nascondere la filatrice schermata iniziale.
    
        <preference name="ShowImageZoomSpinner" value="false"/>
        

## imagezoom.Hide

Respingere la schermata iniziale.

    navigator.imagezoom.hide();
    

### BlackBerry 10, WP8, iOS Quirk

Impostazione `AutoHideImageZoom` del file `config.xml` deve essere `false`. Per ritardare nascondendo la schermata iniziale per due secondi, aggiungere un timer ad esempio nel gestore eventi `deviceready`:

        setTimeout(function() {
            navigator.imagezoom.hide();
        }, 2000);
    

## imagezoom

Visualizza la schermata iniziale.

    navigator.imagezoom.show();
    

L'applicazione non può chiamare `navigator.imagezoom.show()` fino a quando l'app ha iniziato e ha generato l'evento `deviceready`. Ma poiché in genere la schermata iniziale è destinata ad essere visibile prima app ha iniziato, che sembrerebbe per sconfiggere lo scopo della schermata iniziale. Fornendo qualche configurazione nel `file config.xml` sarà automaticamente `show` il tonfo schermo subito dopo il lancio dell'app e prima che completamente ha iniziato e ha ricevuto l'evento `deviceready`. Per ulteriori informazioni su facendo questa configurazione, vedere [icone e schermate iniziali](http://cordova.apache.org/docs/en/edge/config_ref_images.md.html). Per questo motivo, è improbabile che dovete chiamare `navigator.imagezoom.show()` per rendere la schermata visibile per avvio di app.