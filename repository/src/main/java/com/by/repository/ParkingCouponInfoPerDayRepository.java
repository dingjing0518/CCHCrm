package com.by.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.by.model.ParkingCouponInfoPerDay;

public interface ParkingCouponInfoPerDayRepository extends CrudRepository<ParkingCouponInfoPerDay, Integer> {
//	@Query("select month(p.createdTime),sum(p.exchangeNumber),sum(p.useNumber),concat(year(p.createdTime),month(p.createdTime)) from ParkingCouponInfoPerDay p  where year(p.createdTime)=:year and month(p.createdTime)<=:month group by month(p.createdTime) order by month(p.createdTime) asc ")
//	public List<Object[]> findByYearAndMonth(@Param("year") int year, @Param("month") int month);
	
	
	@Query("select year(t.createdTime),sum(t.exchangeNumber),sum(t.useNumber) from ParkingCouponInfoPerDay t group by year(t.createdTime) order by year(t.createdTime) asc")
	List<Object[]> findByYear();
	
	@Query("select quarter(t.createdTime),sum(t.exchangeNumber),sum(t.useNumber) from ParkingCouponInfoPerDay t where year(t.createdTime)=:year group by quarter(t.createdTime) order by quarter(t.createdTime) asc")
	List<Object[]> findBySeason(@Param("year") int year);
	
	@Query("select month(t.createdTime),sum(t.exchangeNumber),sum(t.useNumber) from ParkingCouponInfoPerDay t where year(t.createdTime)=:year and quarter(t.createdTime)=:season group by month(t.createdTime) order by month(t.createdTime) asc")
	List<Object[]> findBySeasonAndMonth(@Param("year") int year,@Param("season") int season);
	
	@Query("select month(t.createdTime),sum(t.exchangeNumber),sum(t.useNumber) from ParkingCouponInfoPerDay t where year(t.createdTime)=:year group by month(t.createdTime) order by month(t.createdTime) asc")
	List<Object[]> findByMonth(@Param("year") int year);
	
	@Query("select day(t.createdTime),t.exchangeNumber,t.useNumber from ParkingCouponInfoPerDay t where year(t.createdTime)=:year and month(t.createdTime)=:month order by t.createdTime asc")
	List<Object[]> findByMonthAndDay(@Param("year") int year,@Param("month") int month);
	
}
