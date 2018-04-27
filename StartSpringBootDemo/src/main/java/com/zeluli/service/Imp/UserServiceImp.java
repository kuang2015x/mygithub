package com.zeluli.service.Imp;

import com.zeluli.dao.UserDao;
import com.zeluli.model.User;
import com.zeluli.service.UserSerivce;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImp implements UserSerivce {

    @Autowired
    private UserDao userDao;
    @Override
    public List<User> getAll() {
        return userDao.selectAll();
    }
}
