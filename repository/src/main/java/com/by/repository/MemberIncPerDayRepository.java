package com.by.repository;

import com.by.model.MemberIncPerDay;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Created by yagamai on 16-3-15.
 */
public interface MemberIncPerDayRepository extends CrudRepository<MemberIncPerDay, Integer> {
	@Query("select month(m.createdTime),sum(m.number),concat(year(m.createdTime),month(m.createdTime)) from MemberIncPerDay m  where year(m.createdTime)=:year and month(m.createdTime)<=:month group by month(m.createdTime) order by month(m.createdTime) asc")
	List<Object[]> findByYearAndMonth(@Param("year") int year, @Param("month") int month);
	
	@Query("select year(m.createdTime),sum(m.number) from MemberIncPerDay m group by year(m.createdTime) order by year(m.createdTime) asc")
	List<Object[]> findByYear();
	
	@Query("select month(m.createdTime),sum(m.number) from MemberIncPerDay m where year(m.createdTime)=:year group by month(m.createdTime) order by month(m.createdTime) asc")
	List<Object[]> findByMonth(@Param("year") int year);
	
	@Query("select quarter(m.createdTime),sum(m.number) from MemberIncPerDay m where year(m.createdTime)=:year group by quarter(m.createdTime) order by quarter(m.createdTime) asc")
	List<Object[]> findBySeason(@Param("year") int year);
	
	@Query("select date(m.createdTime),m.number from MemberIncPerDay m where year(m.createdTime)=:year and month(m.createdTime)=:month order by m.createdTime asc")
	List<Object[]> findByDay(@Param("year") int year, @Param("month") int month);
	
	@Query("select distinct year(m.createdTime) from MemberIncPerDay m")
	List<Integer> findAllValidYear();
	
	@Query("select month(m.createdTime),sum(m.number) from MemberIncPerDay m where year(m.createdTime)=:year and quarter(m.createdTime)=:season group by month(m.createdTime) order by month(m.createdTime) asc")
	List<Object[]> findBySeasonAndMonth(@Param("year") int year,@Param("season") int season);
	
	@Query("select day(m.createdTime),m.number from MemberIncPerDay m where year(m.createdTime)=:year and month(m.createdTime)=:month order by m.createdTime asc")
	List<Object[]> findByMonthAndDay(@Param("year") int year,@Param("month") int month);
	
}
