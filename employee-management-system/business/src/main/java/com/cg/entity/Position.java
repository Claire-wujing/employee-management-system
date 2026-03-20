package com.cg.entity;

import lombok.Data;

import java.util.Date;

@Data
public class Position {
    private Integer positionId;
    private String positionName;
    private String code;
    private Date createTime;
    private Integer status;
}
