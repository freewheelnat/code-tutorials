import 'package:angular/angular.dart';

import 'package:AngularDartFilterList/src/list/list_component.dart';
import 'package:AngularDartFilterList/src/data/items_service.dart';
import 'package:AngularDartFilterList/src/filter/filter_component.dart';
import 'package:AngularDartFilterList/src/filter/filter_service.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [ListComponent, FilterComponent],
  providers: [ClassProvider(ItemsService), ClassProvider(FilterService)],
)
class AppComponent {
  // Nothing here yet. All logic is in ListComponent.
}
