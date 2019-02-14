// Type definitions for Apache Cordova Imagezoom plugin
// Project: https://github.com/apache/cordova-plugin-imagezoom
// Definitions by: Microsoft Open Technologies Inc <http://msopentech.com>
// Definitions: https://github.com/DefinitelyTyped/DefinitelyTyped
// 
// Copyright (c) Microsoft Open Technologies Inc
// Licensed under the MIT license.

interface Navigator {
    /** This plugin displays and hides a splash screen during application launch. */
    imagezoom: {
        /** Dismiss the splash screen. */
        hide(): void;
        /** Displays the splash screen. */
        show(): void;
    }
}