package com.tboss.ssm.mapper;


import java.util.List;

import com.tboss.ssm.po.ItemsCustom;
import com.tboss.ssm.po.ItemsQueryVo;

public interface ItemsMapperCustom {
    public List<ItemsCustom> findItemsList(ItemsQueryVo itemsQueryVo) throws Exception;
}