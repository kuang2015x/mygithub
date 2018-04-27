package com.zeluli.controller;

import com.zeluli.model.User;
import com.zeluli.service.UserSerivce;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserSerivce userSerivce;

    @RequestMapping("/index")
    public String getUsers(Model model){
        List<User> user = userSerivce.getAll();

        model.addAttribute("users",user);

        return "index";
    }
}
