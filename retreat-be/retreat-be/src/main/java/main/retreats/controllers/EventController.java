package main.retreats.controllers;

import main.retreats.config.UserDetailsImpl;
import main.retreats.models.client.Event;
import main.retreats.models.client.EventCategory;
import main.retreats.models.request.NewEventCategoryRequest;
import main.retreats.services.EventService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.net.http.HttpResponse;
import java.util.List;

@RestController
@RequestMapping("/event")
public class EventController {

    private final EventService eventService;

    public EventController(EventService eventService) {
        this.eventService = eventService;
    }

    @GetMapping("/categories")
    public ResponseEntity<List<EventCategory>> getActiveEventCategories() {
        return ResponseEntity.ok(this.eventService.getActiveEventCategories());
    }
    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("/add/category")
    public void getActiveEventCategories(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody NewEventCategoryRequest eventCategoryRequest) {
        this.eventService.addEventCategory(eventCategoryRequest, userDetails.getUsername());
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("/create")
    public Event createEvent() {
        return null;
    }
}
