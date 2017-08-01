package com.by.repository;

import com.by.model.TradingIncPerDay;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Created by yagamai on 16-3-15.
 */
public interface TradingIncPerDayRepository extends CrudRepository<TradingIncPerDay, Integer> {
    @Query("select month(t.createdTime),sum(t.number),sum(t.amount),concat(year(t.createdTime),month(t.createdTime)) from TradingIncPerDay t where year(t.createdTime)=:year and month(t.createdTime)<=:month group by month(t.createdTime) order by month(t.createdTime) asc ")
    List<Object[]> findByYearAndMonth(@Param("year") int year, @Param("month") int month);
	
	@Query("select year(t.createdTime),sum(t.number),sum(t.amount) from TradingIncPerDay t group by year(t.createdTime) order by year(t.createdTime) asc")
	List<Object[]> findByYear();
	
	@Query("select month(t.createdTime),sum(t.number),sum(t.amount) from TradingIncPerDay t where year(t.createdTime)=:year group by month(t.createdTime) order by month(t.createdTime) asc")
	List<Object[]> findByMonth(@Param("year") int year);
	
	@Query("select quarter(t.createdTime),sum(t.number),sum(t.amount) from TradingIncPerDay t where year(t.createdTime)=:year group by quarter(t.createdTime) order by quarter(t.createdTime) asc")
	List<Object[]> findBySeason(@Param("year") int year);
	
	@Query("select date(t.createdTime),t.number,t.amount from TradingIncPerDay t where year(t.createdTime)=:year and month(t.createdTime)=:month order by t.createdTime asc")
	List<Object[]> findByDay(@Param("year") int year, @Param("month") int month);
	
	@Query("select distinct year(t.createdTime) from TradingIncPerDay t")
	List<Integer> findAllValidYear();
	
	@Query("select month(t.createdTime),sum(t.number),sum(t.amount) from TradingIncPerDay t where year(t.createdTime)=:year and quarter(t.createdTime)=:season group by month(t.createdTime) order by month(t.createdTime) asc")
	List<Object[]> findBySeasonAndMonth(@Param("year") int year,@Param("season") int season);
	
	@Query("select day(t.createdTime),t.number,t.amount from TradingIncPerDay t where year(t.createdTime)=:year and month(t.createdTime)=:month order by t.createdTime asc")
	List<Object[]> findByMonthAndDay(@Param("year") int year,@Param("month") int month);
    
}
