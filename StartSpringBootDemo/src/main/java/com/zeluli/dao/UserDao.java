package com.zeluli.dao;

import com.zeluli.model.User;
import java.util.List;

public interface UserDao {

    public List<User> selectAll();
}
