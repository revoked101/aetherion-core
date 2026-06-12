import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { Component } from '@angular/core';
@Component({
  selector: 'aetherion-app-root',
  template: '<aetherion-ui-root></aetherion-ui-root>'
})
class RootComponent {}
platformBrowserDynamic().bootstrapModule(class AppModule {
  static declarations = [RootComponent];
}).catch(err => console.error(err));
