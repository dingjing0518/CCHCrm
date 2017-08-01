package com.by.service.impl;

import com.by.json.ParkingCouponAmountJson;
import com.by.json.ParkingHistoryJson;
import com.by.json.ParkingJson;
import com.by.json.ParkingPayHistoryJson;
import com.by.model.Member;
import com.by.model.ParkingHistory;
import com.by.model.ParkingPayHistory;
import com.by.repository.ParkingPayHistoryRepository;
import com.by.service.ParkingPayHistoryService;
import com.by.utils.CalendarUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;


/**
 * Created by dingjing on 2017/2/8.
 */
@Service
public class ParkingPayHistoryServiceIml implements ParkingPayHistoryService {
    @Value("${couponAmount}")
    private int couponAmount;
    @Autowired
    private ParkingPayHistoryRepository repository;
    @Override
    public ParkingPayHistory save(ParkingJson json) {
        ParkingPayHistory parkingPayHistory=new ParkingPayHistory();
        parkingPayHistory.setCreatedTime(Calendar.getInstance());
        parkingPayHistory.setInTime(CalendarUtil.stringToCalendar("yyyy-MM-dd HH:mm:ss",json.getInTime()));
        parkingPayHistory.setOutTime(CalendarUtil.stringToCalendar("yyyy-MM-dd HH:mm:ss",json.getOutTime()));
        parkingPayHistory.setCarNumber(json.getCarNumber());
        parkingPayHistory.setMember(new Member(json.getMember()));
        parkingPayHistory.setCouponAmount(Double.parseDouble(json.getCouponAmount()));
        parkingPayHistory.setPayAble(Double.parseDouble(json.getPayAble()));
        parkingPayHistory.setPayAmount(Double.parseDouble(json.getPayAmount()));
        return repository.save(parkingPayHistory);
    }

    @Override
    public ParkingCouponAmountJson findByCarNumber(String carNumber) {
        double amount = 0;
        List<ParkingPayHistory> parkingPayHistorys=repository.findByCarNumber(carNumber);
        if(parkingPayHistorys!=null&&parkingPayHistorys.size()>0){
            for(ParkingPayHistory p:parkingPayHistorys){
                amount += p.getCouponAmount();
            }
            if(amount>=couponAmount){
                return new ParkingCouponAmountJson("true");
            }else{
                return new ParkingCouponAmountJson("false");
            }
        }else{
            return new ParkingCouponAmountJson("false");
        }
    }

    @Override
    public Page<ParkingPayHistoryJson> toJson(Page<ParkingPayHistory> lists, Pageable pageable) {
        List<ParkingPayHistoryJson> results = lists.getContent().stream().map(i -> new ParkingPayHistoryJson(i))
                .collect(Collectors.toList());
        return new PageImpl<>(results, pageable, lists.getTotalElements());
    }

    @Override
    public Page<ParkingPayHistory> findByMember(Member member, Pageable pageable) {
        return repository.findByMember(member,pageable);
    }

    @Override
    public List<Object[]> findByCarNameAndMemberAndToday(Member member) {
        Calendar today = Calendar.getInstance();
        return repository.findByCarNameAndMemberAndToday(member,today);
    }
}
