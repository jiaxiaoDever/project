package com.yuhui.core.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yuhui.core.entity.base.Tree;

public class TreeUtils {

	public static <T extends Tree<T>> List<T> formatTree(List<T> treeList, TreeIniter<T> treeIniter) {
		TreeBuilder<T> treeBuilder = new TreeBuilder<T>(treeList, treeIniter);
		return treeBuilder.build();
	}

	public static <T extends Tree<T>> List<T> formatTree(List<T> treeList) {
		return formatTree(treeList, null);
	}

	/**
	 * 获取树格式化器
	 * 
	 * @param treeList
	 * @param treeIniter
	 * @return
	 */
	public static <T extends Tree<T>> TreeBuilder<T> getTreeBuilder(List<T> treeList, TreeIniter<T> treeIniter) {
		TreeBuilder<T> treeBuilder = new TreeBuilder<T>(treeList, treeIniter);
		treeBuilder.build();
		return treeBuilder;
	}

	/**
	 * 格式化树时设置树节点属性接口
	 * 
	 * @author zhangy
	 * 
	 * @param <T>
	 */
	public static interface TreeIniter<T extends Tree<T>> {
		/**
		 * 格式化树时设置树节点属性
		 * 
		 * @param treeNode
		 */
		public void set(T treeNode);

		public void setTreeMap(Map<String, T> mapTree);
	}

	public static class TreeBuilder<T extends Tree<T>> {
		private List<T> treeList;
		private Map<String, T> mapTree = new HashMap<String, T>();
		private List<T> rootList = new ArrayList<T>();
		private TreeIniter<T> treeIniter;

		public TreeBuilder(List<T> treeList) {
			this.treeList = treeList;
		}

		public TreeBuilder(List<T> treeList, TreeIniter<T> treeIniter) {
			this.treeList = treeList;
			this.treeIniter = treeIniter;
			if (this.treeIniter != null) {
				this.treeIniter.setTreeMap(mapTree);
			}
		}

		public List<T> build() {
			for (T treeNode : treeList) {
				if (treeNode.getParentId() == null || "null".equals(treeNode.getParentId())  || "NULL".equals(treeNode.getParentId())||"".equals(treeNode.getParentId())) {
					rootList.add(treeNode);
				}
				mapTree.put(treeNode.getId(), treeNode);
			}
			// 填充字段
			for (T treeNode : treeList) {
				setChildren(treeNode);
				if (treeIniter != null) {
					treeIniter.set(treeNode);
				}
			}
			return rootList;
		}

		private void setChildren(T treeNode) {
			T parent = mapTree.get(treeNode.getParentId());
			if (parent != null) {
				parent.addChild(treeNode);
			}
		}

		public Map<String, T> getMapTree() {
			return mapTree;
		}

		public void setMapTree(Map<String, T> mapTree) {
			this.mapTree = mapTree;
		}

		public List<T> getTreeList() {
			return treeList;
		}

		public void setTreeList(List<T> treeList) {
			this.treeList = treeList;
		}

		public List<T> getRootList() {
			return rootList;
		}

		public void setRootList(List<T> rootList) {
			this.rootList = rootList;
		}

	}

}
