package com.by.repository;

import com.by.model.GiftCouponInfoPerDay;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Created by yagamai on 16-3-18.
 */
public interface GiftCouponInfoPerDayRepository extends CrudRepository<GiftCouponInfoPerDay, Integer> {
	@Query("select year(t.createdTime),sum(t.exchangeNumber),sum(t.useNumber) from GiftCouponInfoPerDay t group by year(t.createdTime) order by year(t.createdTime) asc")
	List<Object[]> findByYear();
	
	@Query("select quarter(t.createdTime),sum(t.exchangeNumber),sum(t.useNumber) from GiftCouponInfoPerDay t where year(t.createdTime)=:year group by quarter(t.createdTime) order by quarter(t.createdTime) asc")
	List<Object[]> findBySeason(@Param("year") int year);
	
	@Query("select month(t.createdTime),sum(t.exchangeNumber),sum(t.useNumber) from GiftCouponInfoPerDay t where year(t.createdTime)=:year and quarter(t.createdTime)=:season group by month(t.createdTime) order by month(t.createdTime) asc")
	List<Object[]> findBySeasonAndMonth(@Param("year") int year,@Param("season") int season);
	
	@Query("select month(t.createdTime),sum(t.exchangeNumber),sum(t.useNumber) from GiftCouponInfoPerDay t where year(t.createdTime)=:year group by month(t.createdTime) order by month(t.createdTime) asc")
	List<Object[]> findByMonth(@Param("year") int year);
	
	@Query("select day(t.createdTime),t.exchangeNumber,t.useNumber from GiftCouponInfoPerDay t where year(t.createdTime)=:year and month(t.createdTime)=:month order by t.createdTime asc")
	List<Object[]> findByMonthAndDay(@Param("year") int year,@Param("month") int month);
}
