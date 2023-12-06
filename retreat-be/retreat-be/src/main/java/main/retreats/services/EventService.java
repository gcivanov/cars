package main.retreats.services;

import main.retreats.models.client.EventCategory;
import main.retreats.models.enums.RequestStatus;
import main.retreats.models.request.NewEventCategoryRequest;
import main.retreats.repositories.client.EventCategoryRepository;
import main.retreats.repositories.client.EventRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventService {
    private final EventRepository eventRepository;
    private final EventCategoryRepository eventCategoryRepository;

    public EventService(EventRepository eventRepository,
                        EventCategoryRepository eventCategoryRepository) {
        this.eventRepository = eventRepository;
        this.eventCategoryRepository = eventCategoryRepository;
    }

    public List<EventCategory> getActiveEventCategories() {
        return this.eventCategoryRepository.findAllByStatusOrderByName(RequestStatus.APPROVED);
    }

    public void addEventCategory(NewEventCategoryRequest eventCategoryRequest, String requestFromEmail) {
        EventCategory newEventCategory = new EventCategory();
        newEventCategory.setName(eventCategoryRequest.getName());
        newEventCategory.setDescription(eventCategoryRequest.getDescription());
        newEventCategory.setStatus(RequestStatus.REQUESTED);
        newEventCategory.setRequestedBy(requestFromEmail);

        this.eventCategoryRepository.save(newEventCategory);
    }

}
