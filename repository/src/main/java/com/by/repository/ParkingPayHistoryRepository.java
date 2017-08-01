package com.by.repository;

import com.by.model.Member;
import com.by.model.ParkingPayHistory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import java.util.Calendar;
import java.util.List;

/**
 * Created by dingjing on 2017/2/8.
 */
public interface ParkingPayHistoryRepository extends PagingAndSortingRepository<ParkingPayHistory,Integer> {
    List<ParkingPayHistory> findByCarNumber(String carNumber);
    Page<ParkingPayHistory> findByMember(Member member, Pageable pageable);
    @Query("select sum(pph.couponAmount),pph.carNumber from ParkingPayHistory pph where pph.member=:member and pph.createdTime=:today group by pph.carNumber")
    List<Object[]>findByCarNameAndMemberAndToday(@Param("member") Member member,@Param("today") Calendar today);
}
