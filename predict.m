function predict(train, test)
	N = 40;

	F = 15;
	testNum = size(test{1})(1);
	trainNum = size(train{1})(1);

	for i = 1:testNum
		clear dist;
		clear X;

		for j = 1:trainNum
			for k = 1:F
				f1 = test{k}(i,:);
				f2 = train{k}(j,:);

				if k<7
					dist(j, k) = l1(f1, f2);
				else 
					if k==7
						dist(j, k) = l2(f1, f2);
					else
						dist(j, k) = x2(f1, f2);
					end
				end
			end
		end


		for k = 1:F
			dist(:,k) = dist(:,k) / max(dist(:,k));
		end

		dist = sum(dist, 2);
		[dist, idx] = sort(dist);

		for j = 1:N
			for k = 1:F+1
				X{k}(:,j) = train{k}(idx(j),:)';
			end
		end


		ans = getTag(test, i, X, F, N);
		ans
		
	end
end


function ret = l1(f1, f2)
	ret = sum(abs(f1 - f2));
end

function ret = l2(f1, f2)
	ret = sum((f1 - f2) .^ 2);
end

function ret = x2(f1, f2)
	ret = 0;
	f1 = f1 / sum(f1);
	f2 = f2 / sum(f2);
	sumF1F2 = f1 + f2;
	sumF1F2 = sumF1F2 + (sumF1F2 == 0);
	ret = sum((f1 - f2) .^ 2 ./ sumF1F2);
end

