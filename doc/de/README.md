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

Dieses Plugin zeigt und verbirgt einen Splash-Screen beim Start der Anwendung.

## Installation

    // npm hosted (new) id
    cordova plugin add cordova-plugin-imagezoom
    // you may also install directly from this repo
    cordova plugin add https://github.com/apache/cordova-plugin-imagezoom.git
    

## Unterstützte Plattformen

  * Amazon Fire OS
  * Android
  * BlackBerry 10
  * iOS
  * Windows Phone 7 und 8
  * Windows 8
  * Windows
  * Browser

## Methoden

  * ImageZoom.Show
  * ImageZoom.Hide

### Android Eigenarten

Sie müssen in Ihrem `"config.xml"`fügen Sie die folgenden Einstellungen:

    <preference name="ImageZoom" value="foo" />
    <preference name="ImageZoomDelay" value="10000" />
    <preference name="SplashMaintainAspectRatio" value="true|false" />
    

Wo Foo ist der Name der Datei Imagezoom, vorzugsweise eine 9-Patch-Datei. Stellen Sie sicher, Splashcreen Dateien zu Ihrem res/xml-Verzeichnis unter den entsprechenden Ordnern hinzuzufügen. Der zweite Parameter stellt dar, wie lange das Imagezoom in Millisekunden angezeigt werden. Es wird standardmäßig auf 3000 ms. Weitere Informationen finden Sie unter [Symbole und Splash-Screens](http://cordova.apache.org/docs/en/edge/config_ref_images.md.html).

"SplashMaintainAspectRatio" Präferenz ist optional. Wenn wahr, Splash-Screen zeichenbaren nicht gestreckt wird, um den Bildschirm passen, sondern stattdessen einfach "" den Bildschirm, wie CSS abdeckt "Hintergrund-Größe: Schutz vor". Dies ist sehr nützlich, wenn Splash-Bildschirm Bilder können nicht, in keiner Weise, zum Beispiel verzerrt werden wenn sie Landschaft oder Text enthalten. Diese Einstellung funktioniert am besten mit Bildern, die große Margen (sichere Bereiche) haben, die sicher auf Bildschirme mit unterschiedlichen Seitenverhältnissen zugeschnitten werden können.

Das Plugin lädt platsch zeichenbaren wenn Ausrichtung ändert, sodass Sie verschiedene Drawables für hoch- und Querformat Ausrichtungen angeben können.

### Browser-Eigenheiten

In Ihrem `"config.xml"`können Sie die folgenden Einstellungen:

    <platform name="browser">
        <preference name="ImageZoom" value="images/browser/imagezoom.jpg" /> <!-- defaults to "img/logo.png" -->
        <preference name="ImageZoomDelay" value="10000" /> <!-- defaults to "3000" -->
        <preference name="ImageZoomBackgroundColor" value="green" /> <!-- defaults to "#464646" -->
        <preference name="ShowImageZoom" value="false" /> <!-- defaults to "true" -->
        <preference name="ImageZoomWidth" value="600" /> <!-- defaults to "170" -->
        <preference name="ImageZoomHeight" value="300" /> <!-- defaults to "200" -->
    </platform>
    

### iOS Macken

  * `FadeImageZoom` (Boolean, standardmäßig auf `true festgelegt`): um zu verhindern, dass den Begrüßungsbildschirm ein-und ausblenden bei ihrer Anzeige Statusänderungen auf `false` festgelegt.
    
        <preference name="FadeImageZoom" value="false"/>
        

  * `FadeImageZoomDuration` (float, Standardwert ist `2`): gibt die Anzahl der Sekunden für den Begrüßungsbildschirm fade Effekt ausgeführt.
    
        <preference name="FadeImageZoomDuration" value="4"/>
        

  * `ShowImageZoomSpinner` (Boolean, standardmäßig auf `true festgelegt`): auf `false` festgelegt wird, um den Begrüßungsbildschirm Spinner auszublenden.
    
        <preference name="ShowImageZoomSpinner" value="false"/>
        

## ImageZoom.Hide

Schließen Sie den Splash-Screen.

    navigator.imagezoom.hide();
    

### BlackBerry 10, WP8, iOS Eigenarten

Die Datei `config.xml` `AutoHideImageZoom` Einstellung muss `false` sein. Verstecken des Begrüßungsbildschirms für zwei Sekunden Verzögerung, fügen Sie einen Timer wie die folgende in der `deviceready`-Ereignishandler:

        setTimeout(function() {
            navigator.imagezoom.hide();
        }, 2000);
    

## ImageZoom.Show

Zeigt den Begrüßungsbildschirm.

    navigator.imagezoom.show();
    

Ihre Anwendung kann nicht `navigator.imagezoom.show()` aufrufen, bis die app begonnen hat und das `deviceready`-Ereignis ausgelöst hat. Aber da in der Regel der Splash-Screen soll sichtbar sein, bevor die Anwendung gestartet wurde, scheint die Niederlage der Zweck des Begrüßungsbildschirms. Somit einige Konfiguration in der Datei `config.xml` werden automatisch die Splash `show` sofort nach Ihrer app-Start und Bildschirm bevor es voll begonnen hat, und das `deviceready`-Ereignis empfangen. Weitere Informationen zu dieser Konfiguration finden Sie unter [Symbole und Splash-Screens](http://cordova.apache.org/docs/en/edge/config_ref_images.md.html). Aus diesem Grund ist es unwahrscheinlich, dass Sie `navigator.imagezoom.show()` damit den Splash-Screen sichtbar ist für app-Start aufrufen müssen.