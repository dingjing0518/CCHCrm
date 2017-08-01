package com.by.repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import com.by.model.Member;

public interface StockIntegralRepository extends CrudRepository<Member, Integer>{
	@Query("select count(*) from Member m  where m.score<500")
	String findBy500();
	
	@Query("select count(*) from Member m  where m.score>=500 and m.score<1000")
	String findBy1000();
	
	@Query("select count(*) from Member m  where m.score>=1000 and m.score<1400")
	String findBy1400();
	
	@Query("select count(*) from Member m  where m.score>=1400 and m.score<1800")
	String findBy1800();
	
	@Query("select count(*) from Member m  where m.score>=1800")
	String findByOther();
	@Query("select count(*) from Member m")
	String findTotal();
}
