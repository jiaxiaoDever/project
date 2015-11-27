package com.jiaxiao.service.impl;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jiaxiao.entity.TbBranchesJx;
import com.jiaxiao.entity.TbStudentJx;
import com.jiaxiao.entity.TbSubject;
import com.jiaxiao.repository.StudentJxDAO;
import com.jiaxiao.service.BranchesJxService;
import com.jiaxiao.service.StudentJxService;
import com.jiaxiao.service.SubjectService;
import com.jiaxiao.service.impl.system.ImportServiceImpl;
import com.jiaxiao.service.system.ImportService;
import com.yuhui.core.repository.mybatis.BaseRepository;

@Service(value = "studentJxService")
@Transactional(readOnly = true)
public class StudentJxServiceImpl extends ImportServiceImpl<TbStudentJx> implements
		StudentJxService, ImportService<TbStudentJx> {

	@Autowired
	private StudentJxDAO studentJxDAO;
	
	@Autowired
	private BranchesJxService branchService;
	
	@Autowired
	private SubjectService subjectService;
	
	public BaseRepository<TbStudentJx> getMybatisDAO() {
		return studentJxDAO;
	}

	public boolean setEntityField(TbStudentJx entity) {
		boolean rs = false;
		if(entity != null){
			String jxName = entity.getJxName();
			String branchName = entity.getBranchName();
			String licenseType = entity.getLicenseType();
			String subjectName = entity.getSubjectName();
			TbBranchesJx branchesJx = new TbBranchesJx();
			branchesJx.setJxName(jxName);
			branchesJx.setBranchName(branchName);
			List<TbBranchesJx> brs = branchService.query(branchesJx);
			if(brs != null && brs.size() > 0){
				TbBranchesJx branchesJx2 = brs.get(0);
				if(branchesJx2 != null){
					entity.setJxId(branchesJx2.getJxId());
					entity.setBranchId(branchesJx2.getBranchId());
				}else{
					entity.setCommon("驾校或网点名称有误");
					return rs;
				}
			}else{
				entity.setCommon("驾校或网点名称有误");
				return rs;
			}
			TbSubject subject = new TbSubject();
			subject.setSubjectName(subjectName);
			List<TbSubject> subjects = subjectService.query(subject);
			if(subjects != null && subjects.size() > 0 && subjects.get(0) != null){				
				entity.setSubjectId(subjects.get(0).getSubjectId());
			}else{
				entity.setCommon("科目名称有误");
				return rs;
			}
			entity.setLicenseTypeCode(licenseType);
			Date date = new Date();
			entity.setCreateDate(date);
			entity.setEditDate(date);
			entity.setStudentStatCode("ZC");
			entity.setStudentStat("正常");
			rs = true;
		}
		return rs;
	}

}
