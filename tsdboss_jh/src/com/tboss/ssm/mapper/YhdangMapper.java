package com.tboss.ssm.mapper;

import com.tboss.ssm.po.Yhdang;
import com.tboss.ssm.po.YhdangExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface YhdangMapper {
    int countByExample(YhdangExample example);

    int deleteByExample(YhdangExample example);

    int deleteByPrimaryKey(String dh);

    int insert(Yhdang record);

    int insertSelective(Yhdang record);

    List<Yhdang> selectByExampleWithBLOBs(YhdangExample example);

    List<Yhdang> selectByExample(YhdangExample example);

    Yhdang selectByPrimaryKey(String dh);

    int updateByExampleSelective(@Param("record") Yhdang record, @Param("example") YhdangExample example);

    int updateByExampleWithBLOBs(@Param("record") Yhdang record, @Param("example") YhdangExample example);

    int updateByExample(@Param("record") Yhdang record, @Param("example") YhdangExample example);

    int updateByPrimaryKeySelective(Yhdang record);

    int updateByPrimaryKeyWithBLOBs(Yhdang record);

    int updateByPrimaryKey(Yhdang record);
}