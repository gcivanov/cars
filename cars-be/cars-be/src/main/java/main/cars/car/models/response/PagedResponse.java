package main.cars.car.models.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.util.Collections;
import java.util.List;

@Getter
@Setter
@SuperBuilder
@AllArgsConstructor
public class PagedResponse<T> {

    private List<T> items;
    private long totalItems;
    private int totalPages;
    private int currentPage;
    private int pageSize;



    public static <T> PagedResponse<T> getPaginatedData(List<T> allData, int page, int size) {
        int index = page * size;
        int dataSize = allData.size();

        if (index < 0 || index >= dataSize) {
            return new PagedResponse<>(Collections.emptyList(), 0, 0, page, size);
        }

        int toIndex = Math.min(index + size, allData.size());
        List<T> paginatedData = allData.subList(index, toIndex);

        return new PagedResponse<>(
                paginatedData,
                allData.size(),
                calculateTotalPages(allData.size(), size),
                page,
                size
        );
    }
    private static int calculateTotalPages(int totalItems, int pageSize) {
        return (int) Math.ceil((double) totalItems / pageSize);
    }
}
