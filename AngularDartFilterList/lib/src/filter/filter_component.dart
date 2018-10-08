import 'package:angular/angular.dart';
import 'package:AngularDartFilterList/src/filter/filter_service.dart';

@Component(
  selector: 'filter',
  templateUrl: 'filter_component.html',
  styleUrls: ['filter_component.css'],
  directives: [coreDirectives],
)
class FilterComponent {

  FilterService _filterService;

  FilterComponent(this._filterService);

  void searchUpdated(String value) {
    _filterService.updateSearch(value);
  }
}