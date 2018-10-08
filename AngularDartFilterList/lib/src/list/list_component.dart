import 'package:angular/angular.dart';
import 'package:AngularDartFilterList/src/data/items_service.dart';
import 'package:AngularDartFilterList/src/data/item.dart';
import 'package:AngularDartFilterList/src/filter/filter_service.dart';

@Component(
  selector: 'my-list',
  templateUrl: 'list_component.html',
  styleUrls: ['list_component.css'],
  directives: [coreDirectives],
)
class ListComponent implements OnInit {

  ItemsService _itemsService;

  FilterService _filterService;

  List<Item> items;

  ListComponent(this._itemsService, this._filterService);

  @override
  void ngOnInit() async {

    _filterService.getFilterEvents().listen((filterValue) async {
      items = await _itemsService.getItems(filterValue);
    });

    items = await _itemsService.getItems('');

  }
}