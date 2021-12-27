from heapq import heappop, heappush

m = [list(map(int, line)) for line in open("input.txt").read().splitlines()]
height, width = len(m), len(m[0])

# Fast Dijkstra version
for i in 1, 5:
    heap, seen = [(0, 0, 0)], {(0, 0)}

    while heap:
        risk, r, c = heappop(heap)
        if r == i * height - 1 and c == i * width - 1:
            print(risk)
            break

        for r_, c_ in (r - 1, c), (r + 1, c), (r, c - 1), (r, c + 1):
            if 0 <= r_ < i * height and \
               0 <= c_ < i * width and \
               (r_, c_) not in seen:
                rd, rm = divmod(r_, height)
                cd, cm = divmod(c_, width)

                seen.add((r_, c_))
                heappush(heap, ( \
                    risk + (m[rm][cm] + rd + cd - 1) % 9 + 1, \
                    r_, c_ \
                ))