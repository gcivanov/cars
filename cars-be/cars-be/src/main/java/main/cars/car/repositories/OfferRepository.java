package main.cars.car.repositories;

import main.cars.car.models.*;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface OfferRepository extends CrudRepository<Offer, Long> {
    Optional<Offer> findByPublisherUrl(String publisherUrl);

    @Query("SELECT model FROM Offer WHERE active = true and endDate > CURRENT_TIMESTAMP")
    List<Model> findModelsWhereActive();

    @Query(value = "SELECT * FROM car_offer WHERE active is true and end_date > CURRENT_TIMESTAMP", nativeQuery = true)
    List<Offer> findAllWhereActive();

    @Query(value = "SELECT * FROM car_offer WHERE active = true and end_date > CURRENT_TIMESTAMP", nativeQuery = true)
    List<Offer> findByOrder(Pageable pageable);


    @Query(value = "SELECT * FROM car_offer WHERE active = true and end_date > CURRENT_TIMESTAMP " +
            " and IF(:price, price >= :price or price_to >= :price, '1') " +
            " and IF(:priceTo, price <= :priceTo or price_to <= :priceTo, '1') " +
            " and IF(COALESCE(:modelIds) is not null, fk_car_model in (:modelIds) , '1') " +
            " and IF(:kilometersFrom, kilometers >= :kilometersFrom, '1') " +
            " and IF(:kilometersTo, kilometers <= :kilometersTo, '1') " +
            " and IF(:yearFrom, year >= :yearFrom, '1') " +
            " and IF(:yearTo, year <= :yearTo, '1') " +
            " and IF(COALESCE(:driveTypeList) is not null, drive_type in (:driveTypeList), '1') " +
            " and IF(COALESCE(:fuelTypeList) is not null, fuel_type in (:fuelTypeList), '1') " +
            " and IF(COALESCE(:transmissionTypeList) is not null, transmission_type in (:transmissionTypeList), '1') " +
            " ", nativeQuery = true)
    List<Offer> findActiveByOrderAndSearch(Pageable pageable, Double price, Double priceTo, List<Long> modelIds,
                                     Integer kilometersFrom, Integer kilometersTo,
                                     Integer yearFrom, Integer yearTo,
                                     List<String> driveTypeList,
                                     List<String> fuelTypeList,
                                     List<String> transmissionTypeList);



    @Query(value = "SELECT * FROM car_offer WHERE " +
            " IF(:price, price >= :price or price_to >= :price, '1') " +
            " and IF(:priceTo, price <= :priceTo or price_to <= :priceTo, '1') " +
            " and IF(COALESCE(:modelIds) is not null, fk_car_model in (:modelIds) , '1') " +
            " and IF(:kilometersFrom, kilometers >= :kilometersFrom, '1') " +
            " and IF(:kilometersTo, kilometers <= :kilometersTo, '1') " +
            " and IF(:yearFrom, year >= :yearFrom, '1') " +
            " and IF(:yearTo, year <= :yearTo, '1') " +
            " and IF(COALESCE(:driveTypeList) is not null, drive_type in (:driveTypeList), '1') " +
            " and IF(COALESCE(:fuelTypeList) is not null, fuel_type in (:fuelTypeList), '1') " +
            " and IF(COALESCE(:transmissionTypeList) is not null, transmission_type in (:transmissionTypeList), '1') " +
            " ", nativeQuery = true)
    List<Offer> findAllByOrderAndSearch(Pageable pageable, Double price, Double priceTo, List<Long> modelIds,
                                     Integer kilometersFrom, Integer kilometersTo,
                                     Integer yearFrom, Integer yearTo,
                                     List<String> driveTypeList,
                                     List<String> fuelTypeList,
                                     List<String> transmissionTypeList);
}
