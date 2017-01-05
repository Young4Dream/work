package com.tboss.ssm.mapper;

import com.tboss.ssm.po.TBsMenuInfo;
import com.tboss.ssm.po.TBsMenuInfoExample;
import java.math.BigDecimal;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TBsMenuInfoMapper {
    int countByExample(TBsMenuInfoExample example);

    int deleteByExample(TBsMenuInfoExample example);

    int deleteByPrimaryKey(BigDecimal menuId);

    int insert(TBsMenuInfo record);

    int insertSelective(TBsMenuInfo record);

    List<TBsMenuInfo> selectByExample(TBsMenuInfoExample example);

    TBsMenuInfo selectByPrimaryKey(BigDecimal menuId);

    int updateByExampleSelective(@Param("record") TBsMenuInfo record, @Param("example") TBsMenuInfoExample example);

    int updateByExample(@Param("record") TBsMenuInfo record, @Param("example") TBsMenuInfoExample example);

    int updateByPrimaryKeySelective(TBsMenuInfo record);

    int updateByPrimaryKey(TBsMenuInfo record);
}