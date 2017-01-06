package com.tboss.ssm.service.impl;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;



import com.tboss.ssm.mapper.ItemsMapper;
import com.tboss.ssm.mapper.ItemsMapperCustom;
import com.tboss.ssm.po.Items;
import com.tboss.ssm.po.ItemsCustom;
import com.tboss.ssm.po.ItemsQueryVo;
import com.tboss.ssm.service.ItemsService;

public class ItemsServiceimpl implements ItemsService{
    @Autowired
    private ItemsMapperCustom itemsMapperCustom;
    @Autowired
    private ItemsMapper itemsMapper;
    
	@Override
	public List<ItemsCustom> findItemsList(ItemsQueryVo itemsQueryVo)
			throws Exception {
		
		return itemsMapperCustom.findItemsList(itemsQueryVo);
	}
	@Override
	public ItemsCustom findItemsById(Integer id) throws Exception {
		
		Items items = itemsMapper.selectByPrimaryKey(id);
		
		ItemsCustom itemsCustom = new ItemsCustom();
		
		BeanUtils.copyProperties(items, itemsCustom);
		
		return itemsCustom;
	}
	@Override
	public void updateItems(Integer id, ItemsCustom itemsCustom)
			throws Exception {
		
		itemsCustom.setId(id);
		itemsMapper.updateByPrimaryKeyWithBLOBs(itemsCustom);
	}
}
