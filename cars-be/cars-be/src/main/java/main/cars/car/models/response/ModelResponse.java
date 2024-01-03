package main.cars.car.models.response;

import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.Objects;

@Builder
@Getter
@Setter
public class ModelResponse {

    @NotNull
    private Long id;

    @NotNull
    private String model;

    private Integer count;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ModelResponse that = (ModelResponse) o;

        if (!Objects.equals(id, that.id)) return false;
        return Objects.equals(model, that.model);
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 72 * result + (model != null ? model.hashCode() : 0);
        return result;
    }
}
