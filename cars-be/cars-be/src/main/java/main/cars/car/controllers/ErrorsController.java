package main.cars.car.controllers;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/err")
public class ErrorsController {

    @PostMapping("/add")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public void addError() {
        //TODO
    }
}
