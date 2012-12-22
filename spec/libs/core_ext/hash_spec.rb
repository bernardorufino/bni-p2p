describe Hash do

  describe "html_merge" do
    
    c1 = 'sample-class1'
    c2 = 'class2'
    c3 = 'sample-class3'
    c4 = 'class4'
    
    n = {id: 'n'}
    s1 = {id: 's1',  class: c1}
    s2 = {id: 's2',  class: c2}
    m12 = {id: 'm12', class: [c1, c2]}
    m34 = {id: 'm34', class: [c3, c4]}
    m1 = {id: 'm1',  class: [c1]}
    w12 = {id: 'w12', class: "#{c1} #{c2}"}
    w34 = {id: 'w34', class: "#{c3} #{c4}"} 

    def self.spec_merged_classes(h1, h2, expected_classes)
      context "when given #{h1[:class].inspect} and #{h2[:class].inspect}" do
        subject { h1.html_merge(h2)[:class].split(' ') }
        it "should not have repeated classes" do 
          should == subject.uniq
        end
        it "should have classes #{expected_classes.join(', ')}" do
          subject.to_set.should == expected_classes.to_set
        end
        it "should have #{expected_classes.size} classes" do
          subject.size.should == expected_classes.size
        end        
      end
    end
    
    specify { s1.html_merge(s2).should include(id: 's2') }
    specify { n.html_merge(n).should_not have_key(:class) }
    
    spec_merged_classes(s1, n, [c1])
    spec_merged_classes(m12, n, [c1, c2])
    spec_merged_classes(m34, n, [c3, c4])
    spec_merged_classes(m1, n, [c1])
    spec_merged_classes(w12, n, [c1, c2])
    spec_merged_classes(n, s1, [c1])
    spec_merged_classes(n, m1, [c1])
    spec_merged_classes(s1, s1, [c1])
    spec_merged_classes(s1, s1, [c1])
    spec_merged_classes(s1, m1, [c1])
    spec_merged_classes(n, m12, [c1, c2])
    spec_merged_classes(n, w12, [c1, c2])
    spec_merged_classes(s1, s2, [c1, c2])
    spec_merged_classes(s2, m1, [c1, c2])
    spec_merged_classes(m1, s2, [c1, c2])
    spec_merged_classes(m12, s1, [c1, c2])
    spec_merged_classes(s1, m12, [c1, c2])
    spec_merged_classes(m1, m12, [c1, c2])
    spec_merged_classes(w12, m12, [c1, c2])
    spec_merged_classes(m12, w12, [c1, c2])
    spec_merged_classes(w12, s1, [c1, c2])
    spec_merged_classes(s1, w12, [c1, c2])
    spec_merged_classes(m12, m12, [c1, c2])
    spec_merged_classes(m34, s1, [c1, c3, c4])
    spec_merged_classes(s1, m34, [c1, c3, c4])
    spec_merged_classes(s1, w34, [c1, c3, c4])
    spec_merged_classes(w34, s1, [c1, c3, c4])
    spec_merged_classes(w12, w34, [c1, c2, c3, c4])
    spec_merged_classes(m12, m34, [c1, c2, c3, c4])
    spec_merged_classes(m12, w34, [c1, c2, c3, c4])
    spec_merged_classes(w12, m34, [c1, c2, c3, c4])
    
  end

end