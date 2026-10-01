package com.microfinance.repository;

import com.microfinance.model.GroupLoanApplication;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

@Repository
public interface GroupLoanApplicationRepo extends JpaRepository<GroupLoanApplication, Long> {

    boolean existsByGroupCodeAndStatusIn(String groupCode, Collection<String> statuses);

    Optional<GroupLoanApplication> findByApplicationNo(String applicationNo);

    List<GroupLoanApplication> findByGroupCode(String groupCode);

    List<GroupLoanApplication> findByGroupCodeOrderByCreatedAtDesc(String groupCode);

    List<GroupLoanApplication> findAllByOrderByCreatedAtDesc();

    @Query("SELECT COALESCE(MAX(g.id), 0) FROM GroupLoanApplication g")
    Long getMaxId();

    @Query("SELECT COUNT(g) > 0 FROM GroupLoanApplication g WHERE g.groupCode = :groupCode AND g.status IN :statuses")
    boolean hasActiveGroupLoan(@Param("groupCode") String groupCode, @Param("statuses") Collection<String> statuses);
}
