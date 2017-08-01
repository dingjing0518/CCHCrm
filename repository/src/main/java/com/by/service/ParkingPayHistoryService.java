package com.by.service;

import com.by.json.ParkingCouponAmountJson;
import com.by.json.ParkingJson;
import com.by.json.ParkingPayHistoryJson;
import com.by.model.Member;
import com.by.model.ParkingPayHistory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Calendar;
import java.util.List;

/**
 * Created by dinging on 2017/2/8.
 */

public interface ParkingPayHistoryService {
    ParkingPayHistory save(ParkingJson pay);
    ParkingCouponAmountJson findByCarNumber(String carNumber);
    Page<ParkingPayHistoryJson> toJson(Page<ParkingPayHistory> lists, Pageable pageable);
    Page<ParkingPayHistory> findByMember(Member member, Pageable pageable);
    List<Object[]> findByCarNameAndMemberAndToday(Member member);
}
