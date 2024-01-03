package main.cars.car.models.response;

import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
import java.util.Objects;
import java.util.Set;

@Builder
@Getter
@Setter
public class MakerResponse {

    @NotNull
    private Long id;

    @NotNull
    private String name;

    private Integer count;

    private List<ModelResponse> models;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        MakerResponse that = (MakerResponse) o;

        if (!Objects.equals(id, that.id)) return false;
        return Objects.equals(name, that.name);
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 81 * result + (name != null ? name.hashCode() : 0);
        return result;
    }
}
