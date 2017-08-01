package com.by.repository;

import java.util.Calendar;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.by.model.TradingPerDay;

/**
 * Created by yagamai on 16-3-15.
 */
public interface TradingAnalysisRepository extends CrudRepository<TradingPerDay, Integer> {
    @Query("select t.floor,sum(t.amount) from TradingPerDay t where t.createdTime>=:startTime and t.createdTime<=:endTime group by t.floor order by t.floor asc ")
    List<Object[]> findByFloor(@Param("startTime") Calendar startTime, @Param("endTime") Calendar endTime);
    
    @Query("select t.shopName,sum(t.amount) from TradingPerDay t where t.createdTime>=:startTime and t.createdTime<=:endTime and t.floor=:floor group by t.shopName ")
    List<Object[]> findByFloorAndBrand(@Param("startTime") Calendar startTime, @Param("endTime") Calendar endTime, @Param("floor") String floor);
    
    @Query("select distinct t.floor from TradingPerDay t order by t.floor asc")
    List<String> findByValidFloor();
}
