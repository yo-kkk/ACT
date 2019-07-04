package com.project.act.models_dto;

import java.io.Serializable;

public class PageDTO implements Serializable{
	private long pg;
	private int pageSize;
	private int blockSize;
	private long totalCount;
	
	private long startNum;
	private long endNum;
	private long startBlock;
	private long endBlock;
	
	private long totalPage;
	
	public PageDTO() {}

	public PageDTO(long pg, int pageSize, int blockSize, long totalCount) {
		super();
		this.pg = pg;
		this.pageSize = pageSize;
		this.blockSize = blockSize;
		this.totalCount = totalCount;
		
		this.pg = pg;
		startNum = (pg - 1) * pageSize + 1;                        
		endNum = pg * pageSize;                                    
		startBlock = (pg - 1) / blockSize * blockSize + 1;         
		endBlock   = (pg - 1) / blockSize * blockSize + blockSize;
		totalPage = totalCount/pageSize;
		if (totalCount % pageSize != 0) totalPage++;
		if (endBlock > totalPage) endBlock = totalPage;
	}

	@Override
	public String toString() {
		return "PageDTO [pg=" + pg + ", pageSize=" + pageSize + ", blockSize=" + blockSize + ", totalCount="
				+ totalCount + "]";
	}

	public long getPg() {
		return pg;
	}

	public void setPg(long pg) {
		this.pg = pg;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public long getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(long totalCount) {
		this.totalCount = totalCount;
	}
	
	

	public long getStartNum() {
		return startNum;
	}

	public long getEndNum() {
		return endNum;
	}

	public long getStartBlock() {
		return startBlock;
	}

	public long getEndBlock() {
		return endBlock;
	}

	public long getTotalPage() {
		return totalPage;
	}
	
	public void set_all() {
		this.startNum = (pg - 1) * pageSize + 1;                        
		this.endNum = pg * pageSize;                                    
		this.startBlock = (pg - 1) / blockSize * blockSize + 1;         
		this.endBlock   = (pg - 1) / blockSize * blockSize + blockSize;
		this.totalPage = totalCount/pageSize;
		if (totalCount % pageSize != 0) this.totalPage++;
		if (endBlock > totalPage) endBlock = this.totalPage;
	}
	
	
}

	
