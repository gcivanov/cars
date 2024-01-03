package main.cars.car.models;

public enum SearchOrderType {
    D("Default"),
    T("Most Recent"),
    N("Newest"),
    L("Price Low to High"),
    H("Price High to Low"),
    V("Most Popular");

    private final String value;

    private SearchOrderType(String value) {
        this.value = value;
    }

}
